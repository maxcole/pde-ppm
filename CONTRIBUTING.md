# Contributing to PPM Packages

## Repository Overview

The PPM ecosystem consists of three repositories:

| Repo | Purpose | Location |
|------|---------|----------|
| [ppm](https://github.com/maxcole/ppm) | Package manager CLI tool | Installed to `~/.local/bin/ppm` |
| [pde-ppm](https://github.com/maxcole/pde-ppm) | Personal Development Environment packages | `~/.local/share/ppm/pde-ppm` |
| [pdt-ppm](https://github.com/maxcole/pdt-ppm) | Product Development Toolkit packages | `~/.local/share/ppm/pdt-ppm` |

## Checking for Updates

```bash
# Update ppm itself
ppm update ppm

# Update all package repos (pulls latest from git)
ppm update

# Check a specific repo manually
cd ~/.local/share/ppm/pde-ppm && git fetch && git status
cd ~/.local/share/ppm/pdt-ppm && git fetch && git status
```

## Contributing a New Package

### 1. Fork the appropriate repo

- **pde-ppm** for personal/environment tools (shell, editor, git config)
- **pdt-ppm** for product/development tools (languages, frameworks, services)

### 2. Clone your fork

```bash
git clone git@github.com:YOUR_USERNAME/pdt-ppm.git ~/Desktop/pdt-ppm-fork
cd ~/Desktop/pdt-ppm-fork
git remote add upstream https://github.com/maxcole/pdt-ppm.git
```

### 3. Keep your fork in sync

```bash
git fetch upstream
git checkout main
git pull upstream main
git push origin main  # sync your fork on GitHub
```

### 4. Create a feature branch

```bash
git checkout -b add-my-feature
```

### 5. Create your package

Packages follow this structure:
```
packages/<name>/
├── install.sh          # Required: installation script
└── home/               # Optional: files to stow to ~
    └── .config/
        └── ...
```

The `install.sh` supports these hooks:
```bash
dependencies() { echo "other-package"; }  # Declare dependencies
install_linux() { ... }                    # Linux-specific install
install_macos() { ... }                    # macOS-specific install
post_install() { ... }                     # Run after install
pre_remove() { ... }                       # Run before remove
post_remove() { ... }                      # Run after remove
```

### 6. Test locally

```bash
ppm install your-package
ppm remove your-package
```

### 7. Submit a PR

```bash
git add .
git commit -m "add my-package"
git push -u origin add-my-feature
gh pr create --repo maxcole/pdt-ppm --title "add my-package" --body "Description..."
```

## MCP Server Configuration

MCP servers for Claude Code are configured at the **project level**, not in PPM packages.

In each project that needs an MCP server:
```bash
cd your-project
claude mcp add --transport http server-name https://server-url/mcp
```

This creates `.claude/config.json` in the project, which should be committed to that project's repo.

## Useful Commands

```bash
ppm list                    # List available packages
ppm install <package>       # Install a package
ppm remove <package>        # Remove a package
ppm update                  # Update all repos
zsrc                        # Reload zsh config after install
```
