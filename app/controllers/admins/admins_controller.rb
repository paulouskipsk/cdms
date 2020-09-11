class Admins::AdminsController < Admins::BaseController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @admins = User.includes(:role).where.not(:role_id => nil)
  end

  def show
    set_role
  end

  def new
    @admin = User.new
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end

  def create
    byebug
    
    @admin = User.new(user_params)
    if @admin.save
      flash[:success] = t('flash.actions.create.m', resource_name: User.model_name.human)
      redirect_to admins_admins_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      @roles = Role.all
      render 'admins/new'
    end
  end

  def update
    if @admin.update(user_params)
      flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      redirect_to admins_admins_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      flash[:success] = t('flash.actions.destroy.m', resource_name: User.model_name.human)
    else
      flash[:error] = I18n.t('flash.actions.destroy.user_admin')
    end
    redirect_to admins_admins_path
  end

  private

  def set_admin
    @admin = User.find(params[:id])
  end

  def set_role
    @role = @admin.role_id ? Role.find(@admin.role_id) : Role.new
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :register_number, :cpf, :active, :avatar, :role_id)
  end
end
