require 'test_helper'

module TutorsPlugin
  class TutorsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @tutor = tutors_plugin_tutors(:one)
    end

    test "should get index" do
      get tutors_url
      assert_response :success
    end

    test "should get new" do
      get new_tutor_url
      assert_response :success
    end

    test "should create tutor" do
      assert_difference('Tutor.count') do
        post tutors_url, params: { tutor: { metadata: @tutor.metadata, user_id: @tutor.user_id } }
      end

      assert_redirected_to tutor_path(Tutor.last)
    end

    test "should show tutor" do
      get tutor_url(@tutor)
      assert_response :success
    end

    test "should get edit" do
      get edit_tutor_url(@tutor)
      assert_response :success
    end

    test "should update tutor" do
      patch tutor_url(@tutor), params: { tutor: { metadata: @tutor.metadata, user_id: @tutor.user_id } }
      assert_redirected_to tutor_path(@tutor)
    end

    test "should destroy tutor" do
      assert_difference('Tutor.count', -1) do
        delete tutor_url(@tutor)
      end

      assert_redirected_to tutors_path
    end
  end
end
