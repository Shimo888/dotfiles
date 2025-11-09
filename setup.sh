#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.json"

echo "🚀 Starting dotfiles setup for macOS..."

if ! command -v jq &> /dev/null; then
    echo "⚠️  jq is not installed. Installing via Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew is not installed. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    brew install jq
fi

create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            local current_source=$(readlink "$target")
            if [ "$current_source" = "$source" ]; then
                echo "  ✓ $target is already correctly linked"
                return
            fi
        fi
        
        echo "  ⚠️  $target already exists"
        read -p "    Do you want to backup and replace it? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$target" "$backup"
            echo "  📦 Backed up to $backup"
        else
            echo "  ⏭️  Skipped $target"
            return
        fi
    fi
    
    ln -s "$source" "$target"
    echo "  ✓ Created symlink: $target -> $source"
}

process_files() {
    local files=$(echo "$1" | jq -r '.[]')
    
    for file in $files; do
        source_path="$SCRIPT_DIR/$file"
        target_path="$HOME/$file"
        
        if [ ! -e "$source_path" ]; then
            echo "  ⚠️  Source file not found: $source_path"
            continue
        fi
        
        create_symlink "$source_path" "$target_path"
    done
}

echo ""
echo "📝 Processing common files..."
common_files=$(jq -c '.common' "$CONFIG_FILE")
process_files "$common_files"

echo ""
echo "📝 Processing macOS specific files..."
mac_files=$(jq -c '.mac' "$CONFIG_FILE")
process_files "$mac_files"

echo ""
echo "✨ Setup completed successfully!"
echo ""
echo "💡 Next steps:"
echo "   - Restart your terminal or run: source ~/.zshrc"
echo "   - Review the symlinks created in your home directory"
