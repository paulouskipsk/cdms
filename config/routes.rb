Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  authenticate :user do
    namespace :admins do
      root to: 'dashboard#index'
      resources :users

      get '/administrators/search/(:term)', to: 'administrators#search_non_admins',
                                            as: 'search_non_administrators'
      resources :administrators, only: [:index, :create, :destroy]

      resources :audience_members
      resources :departments do
        resources :department_modules, except: [:index, :show], as: :modules, path: 'modules'

        get '/members', to: 'departments#members', as: :members
        get '/non-members/search/(:term)', costraints: { term: %r{[^/]+} }, # allows anything except a slash.
                                           to: 'departments#non_members',
                                           as: 'search_non_members'

        post '/members', to: 'departments#add_member', as: :add_member
        delete '/members/:id', to: 'departments#remove_member', as: 'remove_member'
      end
    end
  end

  namespace :users do
    root to: 'dashboard#index'
     get 'team-departments-modules', controller: 'team_departments_modules', action: 'index', as: 'team_departments_modules'
  end
end
