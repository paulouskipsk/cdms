class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    admin = Admin.new name: 'Admin', email: 'admin@admin.com'
    Devise::Mailer.reset_password_instructions(admin, 'faketoken')
  end
end
