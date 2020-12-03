class Relationship < ApplicationRecord
  # class_nameでUserモデルを参照するように設定することでUserをfollowerとfollowedに分ける(関連先のモデルを参照する際の名前を変更)
  # フォローする人とRelationshipを関連付け(1:N)
  belongs_to :follower, class_name: "User"
  # フォローされる人とRelationshipを関連付け(1:N)
  belongs_to :followed, class_name: "User"
  
  # どちらか一つでも無かった場合保存されない
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
