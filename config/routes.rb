Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users
  as :user do
    get 'users/edit', to: 'users/registrations#edit', as: 'edit_user_registration'
    put 'users/edit', to: 'users/registrations#update', as: 'user_registration'
  end

  authenticate :user do
    namespace :users do
      concern :paginatable do
        get '(page/:page)', action: :index, on: :collection, as: ''
      end
      concern :searchable_paginatable do
        get '/search/(:term)/(page/:page)', action: :index, on: :collection, as: :search
      end

      root to: 'dashboard#index'

      resources :documents, concerns: [:paginatable, :searchable_paginatable]
      get 'documents/:id/preview', to: 'documents#preview', as: 'preview_document'

      get 'team-departments-modules', to: 'team_departments_modules#index', action: :index
      get 'show-department/:id', to: 'team_departments_modules#show_department',
                                 action: :show_department, as: 'show_department'
      get 'show-module/:id', to: 'team_departments_modules#show_module', action: :show_module, as: 'show_module'
    end

    namespace :admins do
      root to: 'dashboard#index'

      concern :paginatable do
        get '(page/:page)', action: :index, on: :collection, as: ''
      end
      concern :searchable_paginatable do
        get '/search/(:term)/(page/:page)', action: :index, on: :collection, as: :search
      end

      resources :users, constraints: { id: /[0-9]+/ }, concerns: [:paginatable, :searchable_paginatable]
      resources :administrators, only: [:index, :create, :destroy]
      get '/administrators/search/(:term)', to: 'administrators#search_non_admins',
                                            as: 'search_non_administrators'

      resources :audience_members, constraints: { id: /[0-9]+/ }, concerns: [:paginatable, :searchable_paginatable]
      get 'audience_members/from-csv', to: 'audience_members#from_csv', as: :new_audience_members_from_csv
      post 'audience_members/from-csv', to: 'audience_members#create_from_csv', as: :create_audience_members_from_csv

      resources :departments, constraints: { id: /[0-9]+/ }, concerns: [:paginatable, :searchable_paginatable] do
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
end
