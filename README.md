# tools
Command line tools for Windows

## Directory Structure

- **`bin/`** - All executable scripts and batch files
- **`py/`** - Python utility modules used by the scripts
- **`shortcuts/`** - Windows shortcuts and icons

## Usage

All scripts are located in the `bin/` directory. Add `\\THO_CLOUD\gavyn\repo\tools\bin` to your PATH to use them from anywhere.

### Quick Setup

Run these commands to automatically update your environment:

```powershell
# Add all git repo bin directories to PATH
.\bin\update_path.ps1 -Permanent

# Add all git repo py directories to PYTHONPATH  
.\bin\update_pythonpath.ps1 -Permanent
```

See individual README files in the `bin/` directory for detailed documentation on specific tools.

## Utilities index

- [update_path](bin/update_path_README.md) — Scans workspace git repositories and adds their `bin/` directories to your PATH. Usage: `.in\update_path.ps1 [ -Permanent ]` (or `update_path.bat [permanent]`).
- [update_pythonpath](bin/update_pythonpath_README.md) — Scans workspace git repositories and adds their `py/` directories to your PYTHONPATH. Usage: `.in\update_pythonpath.ps1 [ -Permanent ]` (or `update_pythonpath.bat [permanent]`).