require 'test_helper'

module UsersPlugin
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = users_plugin_users(:one)
    end

    test "should get index" do
      get users_url
      assert_response :success
    end

    test "should get new" do
      get new_user_url
      assert_response :success
    end

    test "should create user" do
      assert_difference('User.count') do
        post users_url, params: { user: { email: @user.email, metadata: @user.metadata, name: @user.name, password: @user.password } }
      end

      assert_redirected_to user_path(User.last)
    end

    test "should show user" do
      get user_url(@user)
      assert_response :success
    end

    test "should get edit" do
      get edit_user_url(@user)
      assert_response :success
    end

    test "should update user" do
      patch user_url(@user), params: { user: { email: @user.email, metadata: @user.metadata, name: @user.name, password: @user.password } }
      assert_redirected_to user_path(@user)
    end

    test "should destroy user" do
      assert_difference('User.count', -1) do
        delete user_url(@user)
      end

      assert_redirected_to users_path
    end
  end
end
