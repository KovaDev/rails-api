Rails.application.routes.draw do
  
  require 'api_constraints'

  mount SabisuRails::Engine => "/sabisu_rails"
  
  namespace :api, defaults: { format: :json } do

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]

    end  

  end  

  devise_for :users


end
