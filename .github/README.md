# Dotfiles

## Overview
Manage configuration files directly in the home directory using a **bare git repository**, eliminating the need for symlinks.

## Setup

```zsh
git clone --bare git@github.com:Shimo888/dotfiles.git $HOME/.dotfiles.git
```

## Usage
Use the `dotfiles` command instead of `git`.
(Refer to `.zsh/aliases.zsh`)

```bash
# Example
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Update settings"
```