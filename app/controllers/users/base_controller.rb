class Users::BaseController < ActionController::Base
  layout 'layouts/users/application'

  add_breadcrumb I18n.t('views.breadcrumbs.home'), :users_root_path
end
