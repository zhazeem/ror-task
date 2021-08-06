Rails.application.routes.draw do

  namespace :v1, defaults: {format: :json} do
    devise_for :users
  end
end
