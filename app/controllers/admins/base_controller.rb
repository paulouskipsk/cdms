class Admins::BaseController < ActionController::Base
  before_action :verify_access_user

  layout 'layouts/admins/application'

  private

  def verify_access_user
    redirect_to users_root_path if current_user.role_id.nil?
  end
end
