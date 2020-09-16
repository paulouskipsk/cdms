require 'test_helper'

class Admins::AdminsControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do
    setup do
      @user = create(:user)
      sign_in create(:admin)
    end

    should 'get index' do
      get admins_admins_path
      assert_response :success
    end

    should 'get new' do
      get new_admins_admin_path
      assert_response :success
    end

    should 'get edit' do
      get edit_admins_admin_path(@user)
      assert_response :success
    end

    should 'get remove as admin' do
      get admins_admins_path
      assert_response :success
    end
  end
  context 'unauthenticated' do
    should 'redirect to login' do
      requests = {
        get: [admins_users_path, admins_admins_path,
              edit_admins_admin_path(1), admins_admin_path(1)],
        post: [admins_admins_path],
        patch: [admins_admin_path(1)],
        delete: [admins_admin_path(1)]
      }

      requests.each do |method, routes|
        routes.each do |route|
          send(method, route)
          assert_redirected_to new_admin_session_path
        end
      end
    end
  end
end
