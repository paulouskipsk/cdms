require 'application_system_test_case'

class EditAudienceMemberTest < ApplicationSystemTestCase
  context 'when user is authenticated' do
    should 'edit with success when the data are valid' do
      admin = create(:admin)
      audience_member = create(:audience_member)
      login_as(admin, scope: :admin)
  
      visit admins_edit_audience_member_path(audience_member.id)
  
      new_email = 'email@email.com'
      new_name = 'new name'
      new_cpf = '086.571.690-02'
  
      fill_in 'audience_member_name', with: new_name
      fill_in 'audience_member_email', with: new_email
      fill_in 'audience_member_cpf', with: new_cpf
  
      click_on I18n.t('simple_form.buttons.save')
  
      assert_current_path admins_list_audience_members_path
      assert_selector('div.alert.alert-success', text: I18n.t('flash.actions.update.m', { resource_name: I18n.t('activerecord.models.audience_member.one') }))
    end

    should 'not edit when the data are invalid' do
      admin = create(:admin)
      audience_member = create(:audience_member)
      login_as(admin, scope: :admin)
  
      visit admins_edit_audience_member_path(audience_member.id)
  
      new_email = ''
      new_name = ''
      new_cpf = ''
  
      fill_in 'audience_member_name', with: new_name
      fill_in 'audience_member_email', with: new_email
      fill_in 'audience_member_cpf', with: new_cpf
  
      click_on I18n.t('simple_form.buttons.save')
  
      within('div.audience_member_name') do
        assert_text(I18n.t('errors.messages.blank'))
      end
      within('div.audience_member_email') do
        assert_text(I18n.t('errors.messages.blank'))
        assert_text(I18n.t('activerecord.errors.models.audience_member.attributes.email.bad_email'))
      end
      within('div.audience_member_email') do
        assert_text(I18n.t('errors.messages.blank'))
        assert_text(I18n.t('activerecord.errors.models.audience_member.attributes.cpf.bad_cpf'))
      end
    end
  end

  context 'when user is not authenticated' do
    should 'redirect to login page' do
      visit admins_edit_audience_member_path(1)
  
      assert_current_path new_admin_session_path
    end
  end
end
