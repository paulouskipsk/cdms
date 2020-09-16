Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'
      resources :users

      resources :admins do
        post 'remove_as_admin', to: 'admins#remove_as_admin', as: 'remove_as_admin'
      end
      get 'users_non_admin', to: 'admins#users_non_admin', as: 'users_non_admin'
      post 'set_user_as_admin', to: 'admins#set_user_as_admin', as: 'set_user_as_admin'
      patch 'set_user_as_admin', to: 'admins#set_user_as_admin', as: 'edit_user_as_admin'

      resources :audience_members
      resources :departments do
        resources :department_modules, except: [:index, :show], as: :modules, path: 'modules'
      end
    end
  end

  as :admin do
    get 'admins/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins/edit', to: 'admins/registrations#update', as: 'admin_registration'
  end
end
