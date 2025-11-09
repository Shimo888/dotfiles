# === .zsh設定の読み込み===
source ~/.zsh/options.zsh    # シェルオプション
source ~/.zsh/prompt.zsh     # プロンプトの表示設定
source ~/.zsh/aliases.zsh    # エイリアス設定
source ~/.zsh/completion.zsh # 補完設定

# プラグイン(整理する)
. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(rbenv init - zsh)"
