---
theme : "night"
transition: "slide"
highlightTheme: "monokai"
slideNumber: true
title: "ザックリLinux"
mouseWheel: true
---

# DS実習102
***
シェル/Linuxコマンドについて

---

# 知識編
***

- プロセス
- 環境変数
- プロンプト
- ディレクトリ
- パス
- デバイスファイル

---

## プロセス
Linuxではプロセスという単位で  
データやメモリが分けて管理される  
サービスは1つないし複数のプロセスで構成される

--

### サービス、あるいはデーモン
***
UNIX系では伝統的にバックグラウンドで処理を行うプロセスをデーモンと言った  
綴りはdaemon

同様のプログラムをWindows系でサービスと言う  
最近ではLinuxでもサービスの語を使う

本サイトではサービスの語を使用する

---

## シェル変数、環境変数
```
echo $PWD  # 前にechoコマンド、$PWDは大文字
hoge=foo  # セットするときは$が要らない
echo $hoge  #-> foo
```
シェルでは`$`を前につけて変数として扱う  
大文字/小文字の区別がある  
使える文字も半角の英数字またはアンダーバー  
1文字目に数字が使えない等の制限あり

--

### 環境変数とは
***
変数のスコープの話  
特にLinuxでは基本的にシェル上で動作するので、  
今動いてるシェルの変数と、  
システムとして保有し続ける変数とがある  
後者を環境変数と言う  

--

### 環境変数の設定
***
環境変数を設定するにはexportコマンドを使用する  
Linuxではログイン時やシェルの起動時にシステム設定ファイルが自動実行されるので、そこに環境変数を設定するコマンドが書かれていることが多い
<!-- {% raw %} -->
```
# gemのパスを通す(インストール及びGEM_HOMEの設定を先にやっておく)
export PATH=${GEM_HOME}/bin:$PATH
```
<!-- {% endraw %} -->

---

## プロンプト
```
user@ADS:~$ 
```
入力待ちであることを示す  
`user@ADS:~$ `の部分がプロンプト<!-- .element: class="fragment current-only" data-code-focus=1 -->

例えばシェルだと待機状態と改行時の2種類あって、それぞれ`$PS1` `$PS2`で定義されている  
任意で変更可(文字色とか表示される文字列とか)<!-- .element: class="fragment current-only" -->

--

### プロンプトの設定例
***
<!-- {% raw %} -->
```
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```
最初の${}は飛ばして
<!-- {% endraw %} -->

色、ユーザー名、@マーク、ホスト名、色リセット、  
コロン(:)、色、現在地、色終了、$マーク+空白  
という内容が規約に従って書かれている

規約を知らないとどうしようもない物が多い

---

## パス

ファイルシステム上での位置をパスという

絶対パス: ルートディレクトリから辿ったパス、一意  
相対パス: 現在地から辿ったパス、現在地次第

ファイル構造を同じにして現在地に応じて違う動き、  
のような使用方法もあるため、どちらがとは言えない
<!-- .element: class="fragment current-only" -->

--

### パスの用途
***
システムやユーザーが使用するコマンドの実体は、  
スクリプトや実行可能形式のプログラムである

絶対パスや相対パスで指定せずとも使用出来るのは、  
シェルのスコープに指定されたディレクトリ内を追加する機能があるからである

この設定を担うのは環境変数$PATHであり、インストールされたプログラムをこのように参照出来るようにすることを「パスを通す」と言う  

--

### パスを通す
***
パスを通す方法は3つあり、まずそもそもパスの通っているディレクトリにプログラムをインストールする方法、パスの通っているディレクトリにプログラムのシンボリックリンクを設置する方法、$PATHに該当プログラムのディレクトリを追加する方法がある  
ミニマムを目指すべし  
また、検索順に気を付けること

---

## デバイスファイル
Linuxでは入出力等に用いるストリームもファイルとしてシステムに保持される  
これらをデバイスファイル/スペシャルファイルと言い、  
`/dev/tty`や`/dev/null`などがある

---

## よく使うあれこれ
***

<div class=.container style="display: flex;" markdown=1>
<div class=.col style="flex: init;" markdown=1>

- pwd
- ls
- cd
- echo
- cat
- sudo

</div>

<div class=.col style="flex: init;" markdown=1>

- cp
- mv
- touch
- mkdir
- rm
- vi / vim / nano

</div>

<div class=.col style="flex: init;" markdown=1>

<!-- {% raw %} -->
- | (pipe)
- \> (redirect)
- ' ' / " "
- `` (backquote)
- () / {}
- <span>$</span>() / <span>$</span>{}
<!-- {% endraw %} -->

</div>
</div>

<!--
その他:

zip tar which env grep awk xarg sed find test if case ...and more!
-->

---

### pwd
***
現在地を表示する  
$PS1の設定によっては、プロンプトに現在地が表示されなかったり、省略されたりする
```
user@ADS:~$ pwd
/home/user
```

--

### ls
***
ファイル(ディレクトリ含む)の一覧を表示する  
後ろにパスを指定することもできる  
デフォルトは列挙、オプションでリスト表示にしたり、詳細を出したりできる  
起動時のスクリプトでls自体がエイリアスになっていて、結果の色付けオプションが指定されている場合が多い
```
user@ADS:~$ ls -la
```

--

### cd
***
現在地(ディレクトリ)を変更する  
無指定だとホームディレクトリに  
移動したい先をコマンドの後ろに指定する
```
user@ADS:~$ cd ~/.ssh
```

--

### echo
***
後ろの文字列を出力するだけ  
変数の確認の他、他のコマンドへの入力を作る起点になったりもする
```
user@ADS:~$ echo $hoge
```

--

### cat
***
ファイルの中身をまとめて(連結して)表示する  
類似コマンド: less head tail more
```
user@ADS:~$ 
```

--

### sudo
***
root権限が必要な時に実行する  
使いたいコマンドの前につけて  
sudoを使えるユーザーは設定で変更可能
```
user@ADS:~$ sudo apt update
```
```
user@ADS:~$ sudo apt upgrate
```

---

### cp
***
ファイルやディレクトリをコピーする  
コピー先での名前指定も出来る

```
# デスクトップに公開鍵をコピー(あれば)
user@ADS:~$ cp ~/.ssh/id_rsa.pub ~/Desktop/koukaikagi.txt
```

--

### mv
***
ファイルを移動する
ファイル名を変更したいときもこのコマンド
```
user@ADS:~$ mv hoge.txt foo.txt
```

--

### touch
***
空のファイルを作成する
```
user@ADS:~$ touch .vimrc
```

--

### mkdir
***
ディレクトリを作成するコマンド  
ファイルとディレクトリは異なる  
オプションで少し便利に
取り返しのつかない操作が少ないので練習向き
```
# ディレクトリ~/hoge/fuga/barをパーミッション700で作成
# 祖先ディレクトリがなければ作成
user@ADS:~$ mkdir -pm 700 ~/hoge/fuga/bar
```

--

### rm
***
ファイル、ディレクトリを削除するコマンド  
システムを破壊する危険があるコマンドNo.1  
慣れたときほど実行に注意するように  
デフォルトだと1ファイルしか削除出来ないのでオプションを併用する  
```
# 万が一のための/rootの削除を禁止するオプション
# デフォルトでこのオプションは書かなくても有効になっているはず
user@ADS:~$ rm --preserve-root ~/hoge
```

--

### vi / vim / nano
***
テキストエディタ  
先に「保存せずに閉じる」「終了する」方法を調べてからコマンドを実行すること
```
user@ADS:~$ vi  # 大体の場合でvim-tinyが起動する
# 普通のvimをインストールすればviのリンクにそのvimが登録される可能性が高い
```

---

### | (pipe)
***
前の出力を後ろのプロセスに渡す
```
user@ADS:~$ ls /usr/bin/ | grep -i python
dh_python2
dh_python3
python
python-config
python2
python2-config
python2.7
python2.7-config
python3
python3-config
python3-futurize
python3-pasteurize
python3.8
python3.8-config
x86_64-linux-gnu-python2-config
x86_64-linux-gnu-python2.7-config
x86_64-linux-gnu-python3-config
x86_64-linux-gnu-python3.8-config
```

--

### \> (redirect)
***
リダイレクトは不等号の大きい方から小さい方にデータ列を渡す  
\>だけでなく<もある他、ヒアドキュメント、ヒアストリングなどもあり、
各プロセスは標準入力、標準出力、標準エラー出力をもつ
```
# 文字列"something special"を出力して、"arigatai.txt"に書き込む
user@ADS:~$ echo something special > arigatai.txt
```
コマンドの結果は文字列で返ってくる場合が多く、  
固定文字列と結合して出力、等の使い方をする
<!-- .element: class="fragment current-only" -->

--

### ' ' / " "
***
' ': シングルクォート;  
" ": ダブルクォート;  
どちらも文字列を表す

処理はバッククォート、パーレンやブレースの後
```
user@ADS:~$ echo "python is $(which python)"
```

--

### \` \`
***
\` \`: backtick, バッククォート; <span>$</span>( )と同じ  
<span>$</span>( )の方がネストしやすく、POSIX標準  
```
`hoge | \`fugafuga\``
```
vs
```
$(hoge | $(fugafuga))
```

--

<!-- {% raw %} -->
### ( ) / <span>{ }</span>
***
(): parenthesis, パーレン; サブシェルで実行  
{}: braces, ブレース; カレントシェルで実行  
<!-- {% endraw %} -->

サブシェルで実行すると変数は引き継ぐけど変更の再反映はしない  
カレントシェルで実行すると変更が反映される
<!-- .element: class="fragment current-only" -->

<!-- {% raw %} -->
```
user@ADS:~$ (echo "変更前: $HOGE"; HOGE='foo'; echo "変更後: $HOGE")
変更前: 
変更後: foo  # 何回やっても一緒
user@ADS:~$ { echo "変更前: $HOGE"; HOGE='foo'; echo "変更後: $HOGE"; }
変更前:      # 2回目以降はここもfooに
変更後: foo
```
<!-- .element: class="fragment fadeup" -->
<!-- {% endraw %} -->

tips: bashだとブレース展開という機能がある
<!-- .element: class="fragment fadeup" -->

--

<!-- {% raw %} -->
### <span>$</span>( ) / <span>${ }</span>
***
<span>$</span>( ): 丸括弧の中を実行して結果を文字列として返す
<span>$</span>{ }: 変数名を波括弧でくくっただけの変数
```
user@ADS:~$ ls $(which python)
/usr/bin/python
```
```
user@ADS:~$ echo ${hoge}fuga  # $hoge=hoge
hogefuga  # {}無しだと${hogefuga}を参照する
```
<!-- {% endraw %} -->