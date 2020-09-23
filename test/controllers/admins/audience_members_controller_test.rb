require 'test_helper'

class Admins::AudienceMembersControllerTest < ActionDispatch::IntegrationTest
  context 'autenticated' do
    setup do
      @audience_member = create(:audience_member)
      sign_in create(:admin)
    end

    should 'get new' do
      get new_admins_audience_member_path
      assert_response :success
    end

    context '#create' do
      should 'successfully' do
        assert_difference('AudienceMember.count', 1) do
          post admins_audience_members_path, params: { audience_member: attributes_for(:audience_member) }
        end
        assert_redirected_to admins_audience_members_path
        assert_equal I18n.t('flash.actions.create.m', resource_name: AudienceMember.model_name.human),
                     flash[:success]
      end

      should 'unsuccessfully' do
        assert_no_difference('AudienceMember.count') do
          post admins_audience_members_path, params: { audience_member: attributes_for(:audience_member, name: '') }
        end

        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]
      end
    end

    context '#update' do
      should 'successfully' do
        patch admins_audience_member_path(@audience_member), params: { audience_member: { name: 'updated' } }
        assert_redirected_to admins_audience_members_path
        assert_equal I18n.t('flash.actions.update.m', resource_name: AudienceMember.model_name.human),
                     flash[:success]
        @audience_member.reload
        assert_equal 'updated', @audience_member.name
      end

      should 'unsuccessfully' do
        patch admins_audience_member_path(@audience_member), params: { audience_member: { name: '' } }
        assert_response :success
        assert_equal I18n.t('flash.actions.errors'), flash[:error]

        name = @audience_member.name
        @audience_member.reload
        assert_equal name, @audience_member.name
      end
    end

    should 'redirect to index' do
      requests = {
        get: [edit_admins_audience_member_path(1), admins_audience_member_path(1)],
        patch: [admins_audience_member_path(1)],
        delete: [admins_audience_member_path(1)]
      }

      requests.each do |method, routes|
        routes.each do |route|
          send(method, route)
          assert_redirected_to admins_audience_members_path
          assert_equal I18n.t('flash.not_found'), flash[:error]
        end
      end
    end
  end

  context 'unauthenticated' do
    should 'redirect to login' do
      requests = {
        get: [admins_audience_members_path, new_admins_audience_member_path,
              edit_admins_audience_member_path(1), admins_audience_member_path(1)],
        post: [admins_audience_members_path],
        patch: [admins_audience_member_path(1)],
        delete: [admins_audience_member_path(1)]
      }

      requests.each do |method, routes|
        routes.each do |route|
          send(method, route)
          assert_redirected_to new_user_session_path
        end
      end
    end
  end
end
