require 'application_system_test_case'

class ListAudienceMembersTest < ApplicationSystemTestCase
  context 'when user is authenticated' do
    should 'list audience members' do
      admin = create(:admin)
      login_as(admin, scope: :admin)
  
      visit admins_list_audience_members_path
  
      assert_current_path admins_list_audience_members_path
      assert_selector('h1.page-title', text: I18n.t('activerecord.models.audience_member.other'))
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_list_audience_members_path
  
      assert_current_path new_admin_session_path
    end
  end
end
