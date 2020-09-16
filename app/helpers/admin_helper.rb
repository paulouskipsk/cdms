module AdminHelper
  def user_as_admin(params)
    admin = User.find(params[:user][:id])
    role_id = params[:user][:role_id]
    admin.can_unlink_administrator?
    return true if admin.update({ role_id: role_id })

    false
  rescue StandartError
    false
  end

  def remove_admin(admin)
    admin.can_unlink_administrator?
    admin.update({ role_id: nil })
  rescue StandartError
    false
  end
end
