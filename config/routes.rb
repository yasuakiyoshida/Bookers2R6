Rails.application.routes.draw do
  # ルーティングの設定を生成したdeviseコントローラーを参照するように
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search' => 'search#search', as: 'search'
  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    get :followings, on: :member # フォロー/フォロワー一覧ページへのルーティング、menberでidが表示されるようになり、
    get :followers, on: :member # followings_user_pathはフォローユーザー一覧のページへ、followers_user_pathはフォロワー一覧ページへ飛ぶようになる
  end
  resources :relationships, only: [:create, :destroy]
end
