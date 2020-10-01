class Admins::BaseController < ActionController::Base
  layout 'layouts/admins/application'

  before_action :verify_user_access

  add_breadcrumb I18n.t('views.breadcrumbs.home'), :admins_root_path

  def verify_user_access
    unless current_user.is?(:admin)
      flash[:error] = I18n.t('flash.not_authorized')
      redirect_to users_root_path 
    end
  end
end
