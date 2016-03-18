require_dependency "online_plugin/application_controller"

module OnlinePlugin
  class ConnectionsController < ApplicationController
    before_action :set_connection, only: [:show, :edit, :update, :destroy]

    # GET /connections
    def index
      @connections = Connection.all
    end

    # GET /connections/1
    def show
    end

    # GET /connections/new
    def new
      @connection = Connection.new
    end

    # GET /connections/1/edit
    def edit
    end

    # POST /connections
    def create
      @connection = Connection.new(connection_params)

      if @connection.save
        redirect_to @connection, notice: 'Connection was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /connections/1
    def update
      if @connection.update(connection_params)
        redirect_to @connection, notice: 'Connection was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /connections/1
    def destroy
      @connection.destroy
      redirect_to connections_url, notice: 'Connection was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_connection
        @connection = Connection.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def connection_params
        params.require(:connection).permit(:category, :metadata)
      end
  end
end
