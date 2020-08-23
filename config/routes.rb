Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      get '/audience_members', to: 'audience_members#index', as: 'list_audience_members'
      get '/audience_members/new', to: 'audience_members#new', as: 'new_audience_member'
      get '/audience_members/:id', to: 'audience_members#edit', as: 'edit_audience_member'
      post '/audience_members', to: 'audience_members#create', as: 'create_audience_member'
      patch '/audience_members', to: 'audience_members#update', as: 'update_audience_member'
      delete '/audience_members/:id', to: 'audience_members#destroy', as: 'destroy_audience_member'
    end
  end

  as :admin do
    get 'admins/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins/edit', to: 'admins/registrations#update', as: 'admin_registration'
  end
end
