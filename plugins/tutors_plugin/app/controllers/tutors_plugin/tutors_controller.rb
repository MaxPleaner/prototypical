require_dependency "tutors_plugin/application_controller"

module TutorsPlugin
  class TutorsController < ApplicationController
    before_action :set_tutor, only: [:show, :edit, :update, :destroy]

    # GET /tutors
    def index
      @tutors = Tutor.all
    end

    # GET /tutors/1
    def show
    end

    # GET /tutors/new
    def new
      @tutor = Tutor.new
    end

    # GET /tutors/1/edit
    def edit
    end

    # POST /tutors
    def create
      @tutor = Tutor.new(tutor_params)

      if @tutor.save
        redirect_to @tutor, notice: 'Tutor was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /tutors/1
    def update
      if @tutor.update(tutor_params)
        redirect_to @tutor, notice: 'Tutor was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /tutors/1
    def destroy
      @tutor.destroy
      redirect_to tutors_url, notice: 'Tutor was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tutor
        @tutor = Tutor.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tutor_params
        params.require(:tutor).permit(:user_id, :metadata)
      end
  end
end
