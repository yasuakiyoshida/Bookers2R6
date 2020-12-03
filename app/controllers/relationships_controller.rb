class RelationshipsController < ApplicationController
  
  def create
    user = User.find(params[:followed_id]) # パラメータ(followed_id)で指定されたフォローされるユーザーの情報を検索して、変数に格納
    following = current_user.follow(user) # followメソッドで引数に渡したユーザーをフォローしていなければcreate(new + save)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to user
    end
  end
  
  def destroy
    user = User.find(params[:id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to user
    end
  end
end
