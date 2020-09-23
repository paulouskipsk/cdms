require 'application_system_test_case'

class LogoutTest < ApplicationSystemTestCase
  context 'success logout' do
    should 'displays success logout message' do
      admin = create(:admin)
      login_as(admin, scope: :admin)

      visit admins_root_path

      click_on admin.name
      click_on I18n.t('views.admin.links.sign_out')

      assert_current_path(new_user_session_path)
      assert_selector('div.alert.alert-info', text: I18n.t('devise.sessions.already_signed_out'))
    end
  end
end
