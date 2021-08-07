Rails.application.routes.draw do

  namespace :v1, defaults: {format: :json} do
    devise_for :users
    resources :posts do
      member do
        resources :comments, param: :comment_id
      end
    end
  end
end
