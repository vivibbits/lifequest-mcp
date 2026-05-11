# ============================================================================
# LifeQuest MCP Bridge — One-Click Installer for Hermes Agent (Windows)
# ============================================================================

param(
    [string]$ApiKey = "",
    [string]$ApiUrl = "https://bbits.app",
    [string]$HermesHome = ""
)

$ErrorActionPreference = "Stop"

Write-Host "⚔️  LifeQuest × Hermes MCP Bridge Installer" -ForegroundColor Magenta

# ─── Resolve Paths ──────────────────────────────────────────────────────────
if (-not $HermesHome) { $HermesHome = $env:HERMES_HOME }
if (-not $HermesHome) { $HermesHome = Join-Path $HOME ".hermes" }
$BridgeDir = Join-Path $HermesHome "mcp-bridges" "lifequest"
$ConfigFile = Join-Path $HermesHome "config.yaml"

if (-not (Test-Path $BridgeDir)) { New-Item -ItemType Directory -Path $BridgeDir -Force | Out-Null }

# ─── Install Bridge ─────────────────────────────────────────────────────────
Write-Host "Installing bridge components..." -ForegroundColor Cyan

$packageJson = @{
    name = "lifequest-mcp-bridge"
    version = "1.0.0"
    private = $true
    type = "module"
    dependencies = @{ "@modelcontextprotocol/sdk" = "^1.12.1"; "dotenv" = "^16.5.0" }
} | ConvertTo-Json
Set-Content -Path (Join-Path $BridgeDir "package.json") -Value $packageJson

$bridgeScript = @'
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { CallToolRequestSchema, ListToolsRequestSchema } from "@modelcontextprotocol/sdk/types.js";

const BBITS_API_URL = process.env.BBITS_API_URL || "https://bbits.app";
const BBITS_API_KEY = process.env.BBITS_API_KEY;

if (!BBITS_API_KEY) { process.exit(1); }

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
}
main();
'@
Set-Content -Path (Join-Path $BridgeDir "bridge.mjs") -Value $bridgeScript

Push-Location $BridgeDir
npm install --silent --no-fund --no-audit
Pop-Location

# ─── Credentials ────────────────────────────────────────────────────────────
if (-not $ApiKey) {
    Write-Host "Enter LifeQuest MCP API Key: " -NoNewline -ForegroundColor Yellow
    $ApiKey = Read-Host
    if (-not $ApiKey) { throw "Key required" }
}

# ─── Configure Hermes ───────────────────────────────────────────────────────
Write-Host "Configuring Hermes Agent..." -ForegroundColor Cyan

$BridgePath = (Join-Path $BridgeDir "bridge.mjs") -replace '\\', '/'

$newMcpBlock = @"

  lifequest:
    command: "node"
    args: ["$BridgePath"]
    env:
      BBITS_API_URL: "$ApiUrl"
      BBITS_API_KEY: "$ApiKey"
    timeout: 120
    connect_timeout: 60
"@

if (-not (Test-Path $ConfigFile)) {
    Set-Content -Path $ConfigFile -Value "mcp_servers:`n$newMcpBlock"
} else {
    $content = Get-Content $ConfigFile -Raw
    if ($content -match "lifequest:") {
        Write-Host "⚠ LifeQuest entry already exists." -ForegroundColor Yellow
    } elseif ($content -match "mcp_servers:") {
        $content = $content -replace "(mcp_servers:)", "`$1$newMcpBlock"
        Set-Content -Path $ConfigFile -Value $content
    } else {
        Add-Content -Path $ConfigFile -Value "`nmcp_servers:`n$newMcpBlock"
    }
}

Write-Host "✅ Installation Complete! Restart Hermes." -ForegroundColor Green
