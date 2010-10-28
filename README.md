Teto
====

Description
-----------
音声を聴くためのニコニコ動画ストリームプロキシです。

 * マイリストなどのページに含まれている動画をダウンロードして、順に再生します。
 * 音声だけを mp3 に変換してプレーヤーで再生しっぱなしにできます。
 * デフォルトでメディアファイルをローカルに保存します。
 * AutoPagerize に対応しているので、はてなブックマークなどを食わせると便利です。

アイコンは [Mini Pixel Icons](http://icondock.com/free/mini-pixel-icons) のものを使用しました。

How to Use
----------
以下のようにして起動し、

	 ./teto.pl --port 9090 http://b.hatena.ne.jp/t/サンドキャニオン

 * http://yourhost:9090/ をブラウザで開くといろいろ見られます。
   * ここから URL の追加やキューの編集ができます。
 * http://yourhost:9090/stream にプレーヤでアクセスすると連続して音声を聴けます。
   * 動的なタイトルの更新に対応しているプレーヤー (iTunes, foobar2000 など) で聴く必要があります.
 * 初回時には script/setup-pit.pl を実行して、ログイン情報を設定する必要があります。
 * 動画ファイルのキャッシュはデフォルトで .cache/ に保存されます。(`--cache-dir` で指定できます)
   * `--readonly` 引数をつけて起動すると、キャッシュの書き込みは行われません。
 * Plack::Runner でサーバを立ち上げますが、たぶん Twiggy 以外だとろくに動きません。

既知の不具合・TODO
------------------
 * 一度切断したり複数接続があったりすると変になる
 * 403 にならないようにする、なったらなったでなんとかする
 * ニコ動以外のサイトに対応
 * Twitter などのソースに対応
 * nm\d+ の対応
 * AE 使ってない HTTP GET で固まるのはどうかと…
 * 進行状況どこかに出す
 * 削除された動画にうまく対応する

Screenshot
----------
[![http://f.hatena.ne.jp/motemen/20101028204941](http://img.f.hatena.ne.jp/images/fotolife/m/motemen/20101028/20101028204941.png)](http://f.hatena.ne.jp/motemen/20101028204941)
