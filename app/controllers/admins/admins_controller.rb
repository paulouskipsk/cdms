class Admins::AdminsController < Admins::BaseController
  before_action :set_admin, only: [:edit, :remove_as_admin]

  def index
    @admins = User.includes(:role).where.not(role_id: nil)
  end

  def new
    @admin = User.new
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end

  def remove_as_admin
    begin
      @admin.can_unlink_administrator?
      if @admin.update({ role_id: nil })
        flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      else
        flash[:error] = I18n.t('flash.actions.destroy.user_admin')
      end
    rescue StandartError
      flash[:error] = I18n.t('flash.actions.destroy.user_admin')
    end
    redirect_to admins_admins_path
  end

  def users_non_admin
    keyword = params[:keyword]

    users = User.where(role_id: nil).where('username LIKE ?', "%#{keyword}%")
    render json: { ok: true, users: users }
  end

  def set_user_as_admin
    @admin = User.find(params[:user][:id])
    begin
      @admin.can_unlink_administrator?
      if @admin.update({ role_id: params[:user][:role_id] })
        flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      else
        flash[:error] = I18n.t('flash.actions.destroy.user_admin')
      end
    rescue StandartError
      flash[:error] = I18n.t('flash.actions.destroy.user_admin')
    end
    redirect_to admins_admins_path
  end

  private

  def set_admin
    @admin = User.find(params[:id] || params[:admin_id])
  end

  def set_role
    @role = @admin.role_id ? Role.find(@admin.role_id) : Role.new
  end

  def user_params
    params.require(:user).permit(:username, :role_id)
  end
end
