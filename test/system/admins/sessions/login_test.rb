require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  context 'success login' do
    should 'displays flash and admins profile link and sign out' do
      admin = create(:admin)

      visit new_admin_session_path

      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: 'password'

      click_on I18n.t('views.session.new.submit')

      assert_current_path(admins_root_path)
      assert_selector 'div.alert.alert-info', text: I18n.t('devise.sessions.signed_in')

      within 'div.header div.dropdown' do
        assert_selector "a[href='#{edit_admin_registration_path}']", visible: false
        assert_selector "a[href='#{destroy_admin_session_path}']", visible: false
        assert_selector 'span.text-default', text: admin.name
        assert_selector 'small.text-muted', text: admin.email
      end
    end
  end

  context 'unsuccess login' do
    should 'displays alert warning' do
      visit new_admin_session_path

      click_on I18n.t('views.session.new.submit')

      assert_current_path(new_admin_session_path)

      attribute_name = Admin.human_attribute_name(:email)
      assert_selector 'div.alert.alert-warning',
                      text: I18n.t('devise.failure.invalid', authentication_keys: attribute_name)
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_root_path

      assert_current_path(new_admin_session_path)
      assert_selector 'div.alert.alert-warning', text: I18n.t('devise.failure.unauthenticated')
    end
  end
end
