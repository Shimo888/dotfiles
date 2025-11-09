# dotfiles

Personal configuration files managed with symlinks.

## Setup

### macOS

```bash
./setup.sh
```

### Windows (Administrator required)

```powershell
.\setup.ps1
```

## Configuration

Edit `config.json` to add or remove files:

```json
{
  "common": [".vimrc", ".ideavimrc"],
  "mac": [".zshrc", ".zsh"],
  "windows": []
}
```
