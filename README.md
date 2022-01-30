# rename_screen_shot.sh
mac でスクリーンショットを保存したら、自動でリネームするためのスクリプトです。

## リネーム対象
リネーム対象は以下です。

- 冒頭に現れる `screenshot ( + 半角スペース)` の部分を削除
- 日付と時刻の間にある半角スペースをアンダースコアに置換

fswatch でスクリーンショットの保存先を監視し、ファイルが保存され次第リネーム処理を行います。

## インストール
1. `$ defaults read com.apple.screencapture name` の値に日本語の文字列が含まれている場合は、含まない形に変更します。

```
$ defaults write com.apple.screencapture name "screenshot"
```

2. `.bashrc` `.zshrc` などの中で、このスクリプトを実行してください。

```bash
$ chmod 700 ~/rename_screen_shot/rename_screen_shot.sh 
$ echo "~/rename_screen_shot/rename_screen_shot.sh" >> ~/.bashrc
```

3. com.apple.screencapture の値を変更した後は、スクリプトを再実行します。複数のプロセスの混在を防ぐため、スクリプトを再実行する際には、すでに実行しているプロセスを kill してからにしてください。

```bash
$ ps aux | grep fswatch | awk '{print $2}' | xargs kill -9
$ exec $SHELL -l
```

## 参考
https://blog.katsubemakito.net/macos/fswatch
