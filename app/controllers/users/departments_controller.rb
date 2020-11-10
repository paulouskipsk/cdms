class Users::DepartmentsController < Users::BaseController
  before_action :set_department
  before_action :can_manager?

  def members
    breadcrumbs_members
    @department_user = DepartmentUser.new
    @department_users = @department.department_users.includes(:user)
  end

  def non_members
    non_members = @department.search_non_members(params[:term])
    render json: non_members.as_json(only: [:id, :name])
  end

  def add_member
    department_users = @department.department_users
    @department_user = department_users.new(department_users_params)

    if @department_user.save
      flash[:success] = I18n.t('flash.actions.add.m', resource_name: User.model_name.human)
      redirect_to users_department_members_path(@department)
    else
      breadcrumbs_members
      @department_users = department_users.includes(:user)
      render :members
    end
  end

  def remove_member
    if try_to_remove_current_user?
      flash[:warning] = I18n.t('flash.actions.reponsible.removeitself')
    else
      department_user = @department.department_users.find_by(user_id: params[:id])
      department_user.destroy
      flash[:success] = I18n.t('flash.actions.remove.m', resource_name: User.model_name.human)
    end

    redirect_to users_department_members_path(@department)
  end

  private

  def try_to_remove_current_user?
    current_user.id == params[:id].to_i
  end

  def can_manager?
    return if current_user.responsible_of?(@department)

    flash[:warning] = t('flash.actions.responsible.non')
    redirect_to users_show_department_path(@department)
  end

  def set_department
    id = params[:department_id] || params[:id]
    @department = Department.find(id)
  end

  def department_params
    params.require(:department).permit(:name, :description, :initials, :local, :phone, :email)
  end

  def department_users_params
    { user_id: params[:department_user][:user_id],
      role: :collaborator }
  end

  def breadcrumbs_members
    add_breadcrumb I18n.t('views.breadcrumbs.show', model: Department.model_name.human, id: @department.id),
                   users_show_department_path(@department)
    add_breadcrumb I18n.t('views.department.members.name'), users_department_members_path(@department)
  end
end
