class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :book
	# validates_uniqueness_of:同一のuser_idに対するbook_idは一意である、という制約
	# scope:で一意性制約を決めるために使用する他のカラムを設定
	validates_uniqueness_of :book_id, scope: :user_id
end
