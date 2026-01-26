# Chat Tools Reference

## Overview

Tools extend VS Code Copilot Chat with specialized capabilities for accomplishing specific tasks. They enable file operations, code search, command execution, web fetching, and more.

VS Code supports three types of tools:
1. **Built-in Tools** - Automatically available, no configuration needed
2. **MCP Tools** - Model Context Protocol servers requiring installation
3. **Extension Tools** - Contributed by VS Code extensions

## Using Tools

### Enabling Tools

1. Open Chat view (Ctrl+Alt+I / Cmd+Ctrl+I)
2. Click the **Configure Tools** button
3. Enable/disable tools per request
4. Select only relevant tools for better results

### Referencing Tools

Reference tools explicitly with `#` followed by the tool name:

```
Summarize the content from #fetch https://example.com
Find usages of #usages AuthService
Fix the issues in #problems
```

Some tools accept parameters directly in prompts.

### Tool Syntax in Agents/Prompts

Use the `#tool:<tool-name>` syntax:

```markdown
Use #tool:search/codebase to find relevant code.
Use #tool:read/readFile to examine contents.
Use #tool:edit/editFiles to make modifications.
```

## Built-in Tools Reference

### File & Directory Management

| Tool | Description |
|------|-------------|
| `#createFile` | Create a new file in the workspace |
| `#createDirectory` | Create a new directory in the workspace |
| `#listDirectory` | List files in a directory |
| `#readFile` | Read the content of a file |

### Code Search & Analysis

| Tool | Description |
|------|-------------|
| `#codebase` | Semantic search across code (auto-locates relevant context) |
| `#fileSearch` | Search for files by glob patterns |
| `#textSearch` | Find text in files using regex |
| `#usages` | Find symbol usages (combines references, implementations, definitions) |
| `#searchResults` | Get results from the Search view |

### File Editing

| Tool | Description |
|------|-------------|
| `#edit` | Enable modifications in the workspace (tool set) |
| `#editFiles` | Apply edits to files |
| `#editNotebook` | Make edits to Jupyter notebooks |

### Task & Command Execution

| Tool | Description |
|------|-------------|
| `#runTask` | Run an existing VS Code task |
| `#createAndRunTask` | Create and run a new task |
| `#runInTerminal` | Run a shell command in terminal |
| `#getTerminalOutput` | Get output from terminal command |
| `#getTaskOutput` | Get output from a VS Code task |
| `#runVscodeCommand` | Execute a VS Code command |

### Testing & Debugging

| Tool | Description |
|------|-------------|
| `#runTests` | Run unit tests in the workspace |
| `#testFailure` | Get test failure data for diagnosis |
| `#startDebugging` | Generate a `launch.json` debug configuration |

### Jupyter Notebook Support

| Tool | Description |
|------|-------------|
| `#runCell` | Run a notebook cell |
| `#readNotebookCellOutput` | Read cell execution output |
| `#getNotebookSummary` | Get notebook cells and details |
| `#newJupyterNotebook` | Create a new Jupyter notebook |

### Project Scaffolding

| Tool | Description |
|------|-------------|
| `#new` | Scaffold a new VS Code workspace |
| `#newWorkspace` | Create a new workspace |
| `#getProjectSetupInfo` | Get project scaffolding instructions |

### External & Web Resources

| Tool | Description |
|------|-------------|
| `#fetch` | Fetch content from a web page |
| `#githubRepo` | Search code within GitHub repositories |
| `#extensions` | Search for VS Code extensions |
| `#installExtension` | Install a VS Code extension |

### Context & Utilities

| Tool | Description |
|------|-------------|
| `#changes` | List source control changes |
| `#problems` | Get workspace problems from Problems panel |
| `#selection` | Get current editor selection |
| `#terminalLastCommand` | Get most recent terminal command |
| `#terminalSelection` | Get current terminal selection |
| `#VSCodeAPI` | Ask about VS Code API and extension development |
| `#todos` | Track task completion with checklist |
| `#runSubagent` | Run task in isolated subagent context |

## Tool Sets

Tools are grouped into sets for easier management:

### `search` — Search files in workspace

| Tool | Syntax | Description |
|------|--------|-------------|
| Semantic search | `#tool:search/codebase` | AI-powered code discovery |
| Symbol usages | `#tool:search/usages` | Find all references |
| Git changes | `#tool:search/changes` | List git changes |
| Search results | `#tool:search/searchResults` | Get Search view results |
| File search | `#tool:search/fileSearch` | Glob-based file search |
| Directory list | `#tool:search/listDirectory` | List directory contents |
| Text search | `#tool:search/textSearch` | Text/regex search |
| Search subagent | `#tool:search/searchSubagent` | Launch search sub-agent |

### `read` — Read files in workspace

| Tool | Syntax | Description |
|------|--------|-------------|
| Read file | `#tool:read/readFile` | Read file contents (full or range) |
| Problems | `#tool:read/problems` | Get compile/lint errors |
| Terminal selection | `#tool:read/terminalSelection` | Get terminal selection |
| Last command | `#tool:read/terminalLastCommand` | Get last terminal command |
| Notebook summary | `#tool:read/getNotebookSummary` | Get notebook cell metadata |
| Cell output | `#tool:read/readNotebookCellOutput` | Read notebook outputs |
| Task output | `#tool:read/getTaskOutput` | Read VS Code task output |

### `edit` — Edit files in workspace

| Tool | Syntax | Description |
|------|--------|-------------|
| Edit files | `#tool:edit/editFiles` | Apply precise modifications |
| Create file | `#tool:edit/createFile` | Create new file |
| Create directory | `#tool:edit/createDirectory` | Create folders |
| Create notebook | `#tool:edit/createJupyterNotebook` | Create Jupyter notebook |
| Edit notebook | `#tool:edit/editNotebook` | Insert/edit/delete cells |

### `execute` — Execute code and applications

| Tool | Syntax | Description |
|------|--------|-------------|
| Run in terminal | `#tool:execute/runInTerminal` | Execute shell command |
| Terminal output | `#tool:execute/getTerminalOutput` | Read command output |
| Run task | `#tool:execute/runTask` | Run existing task |
| Create & run task | `#tool:execute/createAndRunTask` | Create and run task |
| Run tests | `#tool:execute/runTests` | Run unit tests |
| Test failure | `#tool:execute/testFailure` | Get failure info |
| Run cell | `#tool:execute/runNotebookCell` | Run notebook cell |

### `vscode` — VS Code features

| Tool | Syntax | Description |
|------|--------|-------------|
| VS Code API | `#tool:vscode/vscodeAPI` | Extension API docs |
| Extensions | `#tool:vscode/extensions` | Search/manage extensions |
| Simple Browser | `#tool:vscode/openSimpleBrowser` | Open URL in browser |
| Project setup | `#tool:vscode/getProjectSetupInfo` | Scaffold info |
| Install extension | `#tool:vscode/installExtension` | Install by ID |
| New workspace | `#tool:vscode/newWorkspace` | Generate new project |
| Run command | `#tool:vscode/runCommand` | Execute VS Code command |
| Memory | `#tool:vscode/memory` | Access persistent memory |

### `web` — Fetch from the web

| Tool | Syntax | Description |
|------|--------|-------------|
| Fetch | `#tool:web/fetch` | Retrieve web pages |
| GitHub repo | `#tool:web/githubRepo` | Search GitHub repos |

### `agent` — Delegate tasks

| Tool | Syntax | Description |
|------|--------|-------------|
| Run subagent | `#tool:agent/runSubagent` | Launch sub-agent |

### `findTestFiles` — Locate test files

| Tool | Syntax | Description |
|------|--------|-------------|
| Find test files | `#tool:findTestFiles` | Find related test files |

## MCP Tools

Model Context Protocol (MCP) tools extend Copilot with external capabilities.

### Installing MCP Servers

1. Enable: `"chat.mcp.gallery.enabled": true`
2. Open Extensions view
3. Search with `@mcp` filter
4. Install desired servers

### Configuring MCP Servers

Create `.vscode/mcp.json`:

```json
{
  "servers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "custom-api": {
      "type": "http",
      "url": "https://api.example.com/mcp"
    }
  }
}
```

### Using MCP Tools

Reference MCP tools using server-prefixed syntax:

```markdown
tools:
  - memory/*        # All tools from memory server
  - custom-api/query  # Specific tool from server
```

In prompts:
```
Use #tool:memory/store to save this information.
```

## Tool Priority

Tools are resolved in this order:
1. Prompt file tools (if invoked via prompt)
2. Referenced custom agent tools
3. Default agent tools

## Security Considerations

- **Review parameters**: Always review tool parameters before approving
- **Sensitive operations**: Be careful with tools that modify files or run commands
- **MCP servers**: Only add servers from trusted sources
- **External access**: `#fetch` and `#githubRepo` access external resources

## Limitations

- Maximum 128 tools per request (model constraint)
- Some tools require specific context (e.g., `#selection` needs selected text)
- MCP tools require server to be running
- Tool availability varies by agent mode

## Troubleshooting

### Tools Not Available

1. Check tool is enabled in Configure Tools
2. Verify MCP server is running (if MCP tool)
3. Check agent has tool in its `tools` list
4. Verify required context exists (selection, file, etc.)

### Tool Errors

1. Check MCP output logs for server errors
2. Verify network access for web tools
3. Check file permissions for edit tools
4. Review tool parameters in request
