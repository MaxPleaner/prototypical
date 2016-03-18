require 'test_helper'

module TutorialsPlugin
  class TutorialsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @tutorial = tutorials_plugin_tutorials(:one)
    end

    test "should get index" do
      get tutorials_url
      assert_response :success
    end

    test "should get new" do
      get new_tutorial_url
      assert_response :success
    end

    test "should create tutorial" do
      assert_difference('Tutorial.count') do
        post tutorials_url, params: { tutorial: { content: @tutorial.content, metadata: @tutorial.metadata, name: @tutorial.name, user_id: @tutorial.user_id } }
      end

      assert_redirected_to tutorial_path(Tutorial.last)
    end

    test "should show tutorial" do
      get tutorial_url(@tutorial)
      assert_response :success
    end

    test "should get edit" do
      get edit_tutorial_url(@tutorial)
      assert_response :success
    end

    test "should update tutorial" do
      patch tutorial_url(@tutorial), params: { tutorial: { content: @tutorial.content, metadata: @tutorial.metadata, name: @tutorial.name, user_id: @tutorial.user_id } }
      assert_redirected_to tutorial_path(@tutorial)
    end

    test "should destroy tutorial" do
      assert_difference('Tutorial.count', -1) do
        delete tutorial_url(@tutorial)
      end

      assert_redirected_to tutorials_path
    end
  end
end
