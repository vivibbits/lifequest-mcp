import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";

// Load .env from root
const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.join(__dirname, "../.env") });

const BBITS_API_URL = process.env.BBITS_API_URL || "https://bbits.app";
const BBITS_API_KEY = process.env.BBITS_API_KEY;

if (!BBITS_API_KEY) {
  console.error("Error: BBITS_API_KEY environment variable is required.");
  console.error("Please set it in your .env file or export it.");
  process.exit(1);
}

const server = new Server(
  {
    name: "lifequest-bridge",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

/**
 * List available tools by fetching the manifest from the LifeQuest API
 */
server.setRequestHandler(ListToolsRequestSchema, async () => {
  try {
    const res = await fetch(`${BBITS_API_URL}/api/mcp/data`, {
      method: "GET",
      headers: {
        "Authorization": `Bearer ${BBITS_API_KEY}`,
      },
    });

    if (!res.ok) {
      throw new Error(`LifeQuest API returned ${res.status}: ${res.statusText}`);
    }

    const result = await res.json();
    if (!result.success) {
      throw new Error(result.error || "Failed to fetch tool manifest");
    }

    // The LifeQuest API returns the full manifest in data
    return result.data;
  } catch (error) {
    console.error("Error listing tools:", error);
    return {
      tools: [],
    };
  }
});

/**
 * Handle tool calls by forwarding them to the LifeQuest API
 */
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  try {
    const res = await fetch(`${BBITS_API_URL}/api/mcp/data`, {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${BBITS_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        method: name,
        params: args,
      }),
    });

    if (!res.ok) {
      return {
        isError: true,
        content: [{ type: "text", text: `LifeQuest API Error: ${res.status} ${res.statusText}` }],
      };
    }

    const result = await res.json();
    if (!result.success) {
      return {
        isError: true,
        content: [{ type: "text", text: result.error || "Tool execution failed" }],
      };
    }

    return {
      content: [
        {
          type: "text",
          text: typeof result.data === "string" ? result.data : JSON.stringify(result.data, null, 2),
        },
      ],
    };
  } catch (error) {
    return {
      isError: true,
      content: [{ type: "text", text: `Bridge Error: ${error.message}` }],
    };
  }
});

/**
 * Start the server using Stdio transport
 */
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("LifeQuest MCP Bridge running on stdio");
  console.error(`Connected to: ${BBITS_API_URL}`);
}

main().catch((error) => {
  console.error("Fatal error:", error);
  process.exit(1);
});
