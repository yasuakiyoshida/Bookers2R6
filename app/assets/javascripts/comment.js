 // (function(){}) = $(document).ready(function(){})の省略系（HTMLと紐づけ。HTMLの読み込みが終わってからjQueryが実行されるようになる記述）
 // $(document).on('turbolinks:load', function() { }); = turbolinksを、初回読み込み、リロード、ページ切り替えで動くようにする。そうすることによってページを一回読み込まないと上手くいかないという事がなくなる。
 // Turbolinks = 画面遷移を高速化させるライブラリ。これが原因で、Javascriptが正常に機能しなくなる場合がある。
$(document).on('turbolinks:load', function(){
  // $('.セレクタ名').on('submit', function(){
  //   イベント発生時に行われる処理
  // }); = Form要素の送信（submit）処理を操作できる
  $('#new_comment').on('submit', function(e){
    // e.preventDefault(); = コメントを非同期通信にさせたいが、デフォルトだとフォーム送信ボタンが押されるとフォームを送信するための通信が行われるため、そのイベントをキャンセルさせるために書く。
    // e ＝ event、prevent = 妨げる
    e.preventDefault();
    //フォームに入力した値を取得。
    // var 変数名 = 再宣言可能、再代入可能の変数を定義。
    // new = インスタンス作成(これだとFormDataインスタンス)
    // FormData(); = FormDataオブジェクト、サーバーにデータを送信する際に使用する。
    // this = イベントの発生した要素のみを変化
    var comment = new FormData(this);
  })
});