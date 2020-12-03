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
  
  # class_nameでRelationshipモデルを便宜的にfollowerとfollowedに分ける
  # foreign_keyで外部キーを指定、user.のidとforeign_keyが合致しているものを持ってくる、follower_idおよびfollowed_idの適切な方にuser_idを格納
  # フォロー取得。Relationshipモデルのfollower_idにuser_idを格納
  # UserのfollowerとRelationshipのfollowerを関連付け(一人のUser.idは何人もフォローできる(Relationshipのfollower_id)
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  # フォロワー取得。Relationshipモデルのfollowed_idにuser_idを格納
  # UserのfollowedとRelationshipのfollowedを関連付け(一人のUser.idは複数にフォローされる(Relationshipのfollowed_id)
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  
  # 自分がフォローしているユーザ情報を取得。user.followed_user
  # フォローする人(follower)は中間テーブル(Relationshipのfollower)を通じて(入り口:through)、フォローされる人(followed)と紐づく(出口:source)
  has_many :followed_user, through: :follower, source: :followed
  
  # 自分をフォローしているユーザ情報を取得。user.follower_user
  # フォローされる人(followed)は中間テーブル(Relationshipのfollowed)を通じて(入り口:through)、フォローする人(出口:source) と紐づく
  has_many :follower_user, through: :followed, source: :follower
  
  # すでにフォロー済みであればture返す
  def following?(other_user)
    self.follower.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    # 自分がフォローしようとしているユーザーではない場合にture
    unless self == other_user
      # find_or_create_by：followed_idカラムにother_user.idが見つかればfindを実行し、検索結果をRelation、見つからなければ
      # self.follower.create(followed_id: other_user.id)として、フォロー関係を保存(create = new + save) 
      # これにより、既にフォローされている場合にフォローが重複して保存されるのを防ぐ
      self.follower.find_or_create_by(followed_id: other_user.id)
    end
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    # followed_idカラムをfind_byで検索し、other_user.idが存在していれば取得
    following = self.follower.find_by(followed_id: other_user.id)
    # followerが存在していればfollowerをdestroy
    following.destroy if follower
  end
end
