#!/usr/bin/env bash
# ============================================================================
# LifeQuest MCP Bridge — One-Click Installer for Hermes Agent
# ============================================================================

set -euo pipefail

# ─── Colors ──────────────────────────────────────────────────────────────────
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ─── Configuration ───────────────────────────────────────────────────────────
DEFAULT_API_URL="https://bbits.app"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
BRIDGE_DIR="${HERMES_HOME}/mcp-bridges/lifequest"
CONFIG_FILE="${HERMES_HOME}/config.yaml"

echo -e "${MAGENTA}${BOLD}⚔️  LifeQuest × Hermes MCP Bridge Installer${NC}"

# ─── Prerequisites ───────────────────────────────────────────────────────────
if ! command -v node &> /dev/null; then echo -e "${RED}✗ Node.js not found${NC}"; exit 1; fi
if ! command -v npm &> /dev/null; then echo -e "${RED}✗ npm not found${NC}"; exit 1; fi

# ─── Setup Directory ────────────────────────────────────────────────────────
mkdir -p "$BRIDGE_DIR"
cd "$BRIDGE_DIR"

# ─── Install Bridge ─────────────────────────────────────────────────────────
echo -e "${CYAN}Installing bridge components...${NC}"

cat > package.json << 'EOF'
{
  "name": "lifequest-mcp-bridge",
  "version": "1.0.0",
  "private": true,
  "type": "module",
  "dependencies": { "@modelcontextprotocol/sdk": "^1.12.1", "dotenv": "^16.5.0" }
}
EOF

cat > bridge.mjs << 'EOF'
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { CallToolRequestSchema, ListToolsRequestSchema } from "@modelcontextprotocol/sdk/types.js";

const BBITS_API_URL = process.env.BBITS_API_URL || "https://bbits.app";
const BBITS_API_KEY = process.env.BBITS_API_KEY;

if (!BBITS_API_KEY) {
  console.error("Error: BBITS_API_KEY is required.");
  process.exit(1);
}

const server = new Server({ name: "lifequest-bridge", version: "1.0.0" }, { capabilities: { tools: {} } });

server.setRequestHandler(ListToolsRequestSchema, async () => {
  try {
    const res = await fetch(`${BBITS_API_URL}/api/mcp/data`, { headers: { "Authorization": `Bearer ${BBITS_API_KEY}` } });
    const result = await res.json();
    return result.data;
  } catch (e) { return { tools: [] }; }
});

server.setRequestHandler(CallToolRequestSchema, async (req) => {
  const { name, arguments: args } = req.params;
  try {
    const res = await fetch(`${BBITS_API_URL}/api/mcp/data`, {
      method: "POST",
      headers: { "Authorization": `Bearer ${BBITS_API_KEY}`, "Content-Type": "application/json" },
      body: JSON.stringify({ method: name, params: args }),
    });
    const result = await res.json();
    return { content: [{ type: "text", text: typeof result.data === "string" ? result.data : JSON.stringify(result.data, null, 2) }] };
  } catch (e) { return { isError: true, content: [{ type: "text", text: e.message }] }; }
});

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error(`LifeQuest Bridge Online: ${BBITS_API_URL}`);
}
main().catch(e => process.exit(1));
EOF

npm install --silent --no-fund --no-audit

# ─── Credentials ────────────────────────────────────────────────────────────
API_URL="${BBITS_API_URL:-}"
if [ -z "$API_URL" ]; then
    read -r -p "Enter LifeQuest API URL (default: $DEFAULT_API_URL): " API_URL
    API_URL="${API_URL:-$DEFAULT_API_URL}"
fi

API_KEY="${BBITS_API_KEY:-}"
if [ -z "$API_KEY" ]; then
    read -r -p "Enter LifeQuest MCP API Key: " API_KEY
    if [ -z "$API_KEY" ]; then echo -e "${RED}✗ Key required${NC}"; exit 1; fi
fi

# ─── Configure Hermes ───────────────────────────────────────────────────────
echo -e "${CYAN}Configuring Hermes Agent...${NC}"

BRIDGE_PATH="${BRIDGE_DIR}/bridge.mjs"

# Prepare the YAML block
# We use single quotes for the heredoc to prevent expansion bugs
cat > /tmp/lifequest_mcp.yaml << EOF
  lifequest:
    command: "node"
    args: ["$BRIDGE_PATH"]
    env:
      BBITS_API_URL: "$API_URL"
      BBITS_API_KEY: "$API_KEY"
    timeout: 120
    connect_timeout: 60
EOF

if [ ! -f "$CONFIG_FILE" ]; then
    echo "mcp_servers:" > "$CONFIG_FILE"
    cat /tmp/lifequest_mcp.yaml >> "$CONFIG_FILE"
else
    if grep -q "lifequest:" "$CONFIG_FILE"; then
        echo -e "${YELLOW}⚠  LifeQuest entry already exists. Please update it manually if needed.${NC}"
    elif grep -q "mcp_servers:" "$CONFIG_FILE"; then
        # Insert after mcp_servers:
        sed -i "/mcp_servers:/r /tmp/lifequest_mcp.yaml" "$CONFIG_FILE"
    else
        echo "mcp_servers:" >> "$CONFIG_FILE"
        cat /tmp/lifequest_mcp.yaml >> "$CONFIG_FILE"
    fi
fi

rm /tmp/lifequest_mcp.yaml

echo -e "\n${GREEN}✅ Installation Complete!${NC}"
echo -e "Restart Hermes and try: ${BOLD}\"What are my quests?\"${NC}\n"
