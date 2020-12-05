class SearchController < ApplicationController
  
  # params["search"]には{ "value"=>"入力した文字列", "model"=>"モデル名", "how"=>"検索方法の変数" }のハッシュが入っている
  # params["search(ハッシュ)"]["model(キー)"]で値を出力する(これだとモデル名取得)
  def search
    # 選択したmodel(ユーザーか投稿か)を@modelに代入
    @model = params["search"]["model"]
    # フォームに入力した文字列(value)を@valueに代入
    @value = params["search"]["value"]
    # 選択した検索方法(how)を@howに代入
    @how = params["search"]["how"]
    # search_forの引数にインスタンス変数を定義
    # @datasに最終的な検索結果が入る
    @datas = search_for(@how, @model, @value)
  end

  private

  # 完全一致：モデル名.where('カラム名 like ?','検索したい文字列')
  # like ? でも Like ? でもどっちでもよさそう
  def match(model, value)
    # modelがuserの場合の処理
    if model == 'user'
      # whereでvalueと完全一致するnameを探します
      User.where("name LIKE ?", "#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end

  # 前方一致：モデル名.where('カラム名 like ?','検索したい文字列%')
  def forward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end
  
  # 後方一致：モデル名.where('カラム名 like ?','%検索したい文字列')
  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  # 部分一致：モデル名.where('カラム名 like ?','%検索したい文字列%')
  # %文字列%は、文字列のどの部分にでも検索したい文字列が含まれていればOK
  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end

  # 検索方法を決める処理
  def search_for(how, model, value)
    # case 対象のオブジェクトや式
    case how
    # when 値1
    #   値1に一致する場合の処理
    when 'match'
      # howがmatchと一致すれば def match の処理に進む
      match(model, value)
    # when 値2
    #   値2に一致する場合の処理
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    # else
    #   どれにも一致しない場合の処理
    end
  end
end
