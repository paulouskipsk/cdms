class Users::TeamDepartmentsModulesController < Users::BaseController
  def index                          
    # @departments = User.joins(:departments, :department_modules).where(users: {id: current_user.id.to_s})                  

    @departments = DepartmentUser.includes(:department, :user).where(users: {id: current_user.id.to_s})
    @modules = DepartmentModuleUser.includes(:user, :department_module).where(users: {id: current_user.id.to_s})


  end
end
