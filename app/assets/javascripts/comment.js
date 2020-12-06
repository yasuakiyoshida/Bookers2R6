 // (function(){}) = $(document).ready(function(){})の省略系（HTMLと紐づけ。HTMLの読み込みが終わってからjQueryが実行されるようになる記述）
 // $(document).on('turbolinks:load', function() { }); = turbolinksを、初回読み込み、リロード、ページ切り替えで動くようにする。そうすることによってページを一回読み込まないと上手くいかないという事がなくなる。
 // Turbolinks = 画面遷移を高速化させるライブラリ。これが原因で、Javascriptが正常に機能しなくなる場合がある。
$(document).on('turbolinks:load', function(){
  // buildHTML = 非同期でコメント一覧に追加していくコメントのHTMLを作成
  function buildHTML(book_comment) {
    
    var comment = book_comment.comment ? `${ book_comment.comment }` : "";
    var img = message.image ? `<img src= ${ message.image }>` : "";
    var html = `<div class="message" data-id="${message.id}">
                  <div class="message__detail">
                    <p class="message__detail__current-user-name">
                      ${message.user_name}
                    </p>
                    <p class="message__detail__date">
                      ${message.date}
                    </p>
                  </div>
                  <p class="message_body">
                    <div>
                    ${content}
                    </div>
                    ${img}
                  </p>
                </div>`
  return html;
  }
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
    var book_comment = new FormData(this);
    // window.location.href = URLを取得、もしくは設定するプロパティ。
    // $(this).attr('action')でも可能 = $(指定したい要素など).attr('属性値');で属性値に対する値を取得する、action属性にはURLパターンが含まれているので遷移先として指定できる。
    var url = (window.location.href);
    // $.ajax() = Ajaxを実装するメソッド
    $.ajax({  
      // url:オプション = リクエストを送信する先のURL
      url: url,
      // type: = "POST"か"GET"を指定して、HTTP通信の種類を設定。初期値は"GET"(送りたいのはbook_commentsコントローラのcreateアクションだからPOST)
      type: 'POST',
      // data: = サーバに送信する値（ここではフォームに入力した値）
      data: book_comment,
      // dataType: = サーバから返されるデータの型を指定。"json"でJSON形式のデータとして評価し、JavaScriptのオブジェクトに変換する
      dataType: 'json',
      // processData: = dataに指定したオブジェクトをクエリ文字列に変換するかどうかを設定
      processData: false,
      // contentType: = サーバにデータを送信する際に用いるcontent-typeヘッダの値
      contentType: false
    })
  })
});