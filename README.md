# GT Tools

Command-line utilities for Windows development workflows, focused on Git operations, path management, and environment configuration.

## Directory Structure

- **[bin/](bin/)** - Executable scripts and batch files
- **[py/](py/)** - Python utility modules
- **[shortcuts/](shortcuts/)** - Windows shortcuts and icons

## Prerequisites

Set the `DEV_PATH` environment variable to your development root directory. Many tools use this to locate repositories:

```powershell
# Example
[System.Environment]::SetEnvironmentVariable('DEV_PATH', 'R:\repo', 'User')
```

## Quick Setup

Add the tools to your environment for system-wide access:

```powershell
# Add all git repo bin directories to PATH
.\bin\update_path.ps1 -Permanent

# Add all git repo py directories to PYTHONPATH  
.\bin\update_pythonpath.ps1 -Permanent
```

See [update_path_README.md](bin/update_path_README.md) and [update_pythonpath_README.md](bin/update_pythonpath_README.md) for detailed documentation.

## Available Tools

### Environment & Path Management

- **[env.bat](bin/env.bat)** - Opens the Windows Environment Variables editor
- **[update_path.bat](bin/update_path.bat)** / **[.ps1](bin/update_path.ps1)** - Scans workspace git repositories and adds their `bin/` directories to PATH. See [documentation](bin/update_path_README.md)
- **[update_pythonpath.bat](bin/update_pythonpath.bat)** / **[.ps1](bin/update_pythonpath.ps1)** - Scans workspace git repositories and adds their `py/` directories to PYTHONPATH. See [documentation](bin/update_pythonpath_README.md)
- **[print_env.bat](bin/print_env.bat)** - Displays environment variables
- **[toggle_log_debug.bat](bin/toggle_log_debug.bat)** - Toggle debug logging on/off
- **[repo.bat](bin/repo.bat)** - Navigate to the DEV_PATH repository root

### Git Operations

- **[clone.bat](bin/clone.bat)** - Clone a repository with automatic directory structure creation based on org/repo name (requires DEV_PATH)
- **[branch.bat](bin/branch.bat)** - Create a new branch and push it to remote
- **[checkout.bat](bin/checkout.bat)** - Git checkout wrapper
- **[pull_main.bat](bin/pull_main.bat)** - Pull latest changes from main branch while staying on current branch
- **[push_rebase.bat](bin/push_rebase.bat)** - Push with rebase
- **[latest_tag.bat](bin/latest_tag.bat)** - Show the latest git tag
- **[list_tags.bat](bin/list_tags.bat)** - List all git tags

### Path Utilities

- **[normpath.bat](bin/normpath.bat)** - Normalize file paths (uses [normpath.py](py/normpath.py))
- **[path_tounix.bat](bin/path_tounix.bat)** - Convert Windows paths to Unix format
- **[path_towindows.bat](bin/path_towindows.bat)** - Convert Unix paths to Windows format

### File Operations

- **[explore.bat](bin/explore.bat)** - Open Windows Explorer at current directory
- **[persistent_copy.bat](bin/persistent_copy.bat)** - Persistent file copy operation (uses [persistent_copy.py](py/persistent_copy.py))

### System Utilities

- **[vpn_status.ps1](bin/vpn_status.ps1)** - Check VPN connection status
- **[stop_killer_services.bat](bin/stop_killer_services.bat)** - Stop resource-intensive services

### Development

- **[func.cmd](bin/func.cmd)** - Shared functions library for batch scripts
- **[EXAMPLES_flag_handling.bat](bin/EXAMPLES_flag_handling.bat)** - Example of standardized flag handling

## Usage Patterns

Most tools support the `-h` or `--help` flag for usage information:

```batch
clone --help
branch -h
update_path --help
```

### Common Workflows

**Clone a repository:**
```batch
clone https://github.com/organization/repo-name.git
# Creates: %DEV_PATH%\organization\repo\name\
```

**Create and push a new branch:**
```batch
branch feature-name
```

**Update main branch without switching:**
```batch
pull_main
```

**Normalize a file path:**
```batch
normpath "C:\Some Path\With Spaces\file.txt"
```

## Python Modules

The [py/](py/) directory contains reusable Python modules:

- **[normpath.py](py/normpath.py)** - Path normalization utilities
- **[persistent_copy.py](py/persistent_copy.py)** - Robust file copy operations
- **[print_env.py](py/print_env.py)** - Environment variable printing utilities

## Contributing

When adding new tools:

1. Place executables in [bin/](bin/)
2. Place Python modules in [py/](py/)
3. Use [func.cmd](bin/func.cmd) functions for consistency
4. Add help text with `-h`/`--help` flag support
5. Update this README with tool description

## License

Part of the GT Tools collection.
