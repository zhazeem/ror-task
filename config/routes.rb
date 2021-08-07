Rails.application.routes.draw do

  namespace :v1, defaults: {format: :json} do
    devise_for :users
    resources :posts
  end
end
