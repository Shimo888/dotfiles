# エイリアス設定
alias ll='ls -l'                     # 詳細情報表示
alias la='ls -la'                    # 隠しファイルも表示
alias -g NOERR='2>/dev/null'         # エラー非表示のグローバルエイリアス

# dotfiles用git command
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'