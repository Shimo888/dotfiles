# 補完設定
fpath=(~/.zsh/completion $fpath)  # 補完関数の検索パス
autoload -U compinit              # compinit 関数をロード
compinit -u                       # 補完初期化（未署名の補完も有効化）