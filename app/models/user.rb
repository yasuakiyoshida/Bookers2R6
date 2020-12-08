class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  # フォロー取得。Relationshipモデルのfollower_idにuser_idを格納
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得。Relationshipモデルのfollowed_idにuser_idを格納
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 自分がフォローしているユーザ情報を取得。user.followed_user
  has_many :followed_user, through: :follower, source: :followed
  # 自分をフォローしているユーザ情報を取得。user.follower_user
  has_many :follower_user, through: :followed, source: :follower
  
  # すでにフォロー済みであればture返す
  def following?(other_user)
    self.followed_user.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    # 自分がフォローしようとしているユーザーではない場合にture
    unless self == other_user
      self.follower.find_or_create_by(followed_id: other_user.id)
    end
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    # followed_idカラムをfind_byで検索し、other_user.idが存在していれば取得
    following = self.follower.find_by(followed_id: other_user.id)
    following.destroy if follower
  end
  
  # jpprefectureを呼び出す
  # (モデルにprefectureというインスタンスメソッドが作成され、都道府県コード,都道府県名を参照できるようになる)
  include JpPrefecture
  # prefecture_codeはuserが持っているカラム
  jp_prefecture :prefecture_code
  
  # @user.prefecture_nameで都道府県名を参照出来る様にする
  # postal_codeからprefecture_nameに変換するメソッドを用意
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
