$(function() {
  // .jpostalを指定するセレクタを選択(デベロッパーツールで確認するとid="user_postcode")
  return $('#user_postcode').jpostal({
    // 郵便番号の入力欄が１つの場合の指定
    postcode: ['#user_postcode'],
    // 住所欄の自動入力指定
    address: {
      '#user_prefecture_code': '%3', // 都道府県が入力される
      '#user_address_city': '%4', // 市が入力される
      '#user_address_street': '%5', // 町村が入力される
    },
  });
});
