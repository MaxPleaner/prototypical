require 'test_helper'

module OnlinePlugin
  class ConnectionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @connection = online_plugin_connections(:one)
    end

    test "should get index" do
      get connections_url
      assert_response :success
    end

    test "should get new" do
      get new_connection_url
      assert_response :success
    end

    test "should create connection" do
      assert_difference('Connection.count') do
        post connections_url, params: { connection: { category: @connection.category, metadata: @connection.metadata } }
      end

      assert_redirected_to connection_path(Connection.last)
    end

    test "should show connection" do
      get connection_url(@connection)
      assert_response :success
    end

    test "should get edit" do
      get edit_connection_url(@connection)
      assert_response :success
    end

    test "should update connection" do
      patch connection_url(@connection), params: { connection: { category: @connection.category, metadata: @connection.metadata } }
      assert_redirected_to connection_path(@connection)
    end

    test "should destroy connection" do
      assert_difference('Connection.count', -1) do
        delete connection_url(@connection)
      end

      assert_redirected_to connections_path
    end
  end
end
