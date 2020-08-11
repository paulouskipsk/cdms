require 'application_system_test_case'

class EditProfileTest < ApplicationSystemTestCase

  should 'updates with success when the data are valid' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit edit_admin_registration_path

    new_email = 'email@email.com'
    new_name = 'new name'

    fill_in 'admin_name', with: new_name
    fill_in 'admin_email', with: new_email
    fill_in 'admin_current_password', with: admin.password

    click_on I18n.t('devise.registrations.edit.update')

    assert_current_path edit_admin_registration_path
    assert_selector('div.alert.alert-info', text: I18n.t('devise.registrations.updated'))

    within('div.header a.nav-link') do
      assert_text new_name
      assert_text new_email
    end

    assert_field 'admin_name', with: new_name
    assert_field 'admin_email', with: new_email
  end


  should 'not update with invalid data' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit edit_admin_registration_path

    fill_in 'admin_name', with: ''
    fill_in 'admin_email', with: 'email'
    fill_in 'admin_current_password', with: admin.password

    click_on I18n.t('devise.registrations.edit.update')

    assert_selector('div.alert.alert-danger', text: I18n.t('simple_form.error_notification.default_message'))

    within('div.admin_name') do
      assert_text(I18n.t('errors.messages.blank'))
    end
    within('div.admin_email') do
      assert_text(I18n.t('errors.messages.invalid'))
    end
    within('div.admin_current_password') do
      key = 'devise.registrations.edit.current_password_to_confirm'
      assert_text(I18n.t(key))
    end
  end
end

