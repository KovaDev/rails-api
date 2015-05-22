Rails.application.routes.draw do
  
  require 'api_constraints'
  
  namespace :api, defaults: { format: :json } do

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      resources :users, :only => [:show, :create]

    end  

  end  

  devise_for :users

end
