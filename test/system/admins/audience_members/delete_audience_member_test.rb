require 'application_system_test_case'

class DeleteAudienceMemberTest < ApplicationSystemTestCase
  context 'when user is authenticated' do
    should 'delete audience member', js: true do
      admin = create(:admin)
      create(:audience_member)
      login_as(admin, scope: :admin)
      visit admins_list_audience_members_path
      find(:css, 'i.fe.fe-trash-2').click
      confirm_dialog = page.driver.browser.switch_to.alert
      confirm_dialog.accept
      assert_current_path admins_list_audience_members_path
      assert_selector(
        'div.alert.alert-success',
        text: t('flash.actions.destroy.m', { resource_name: t('activerecord.models.audience_member.one') })
      )
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_list_audience_members_path
      assert_current_path new_user_session_path
    end
  end
end
