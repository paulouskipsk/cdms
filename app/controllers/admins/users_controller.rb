class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; 
    set_role
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('flash.actions.create.m', resource_name: User.model_name.human)
      redirect_to admins_users_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      @roles = Role.all
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('flash.actions.update.m', resource_name: User.model_name.human)
      redirect_to admins_users_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t('flash.actions.destroy.m', resource_name: User.model_name.human)
    redirect_to admins_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_role
    if @user.role_id
      @role = Role.find(@user.role_id)
    else
      @role = Role.new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :register_number, :cpf, :active, :avatar, :role_id)
  end
end
