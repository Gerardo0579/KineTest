class Api::ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
    render :index
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    render :show
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      render :show, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    if @activity.update(activity_params)
      render :show, status: :ok, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      
      begin
        @activity = Activity.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @activity = Assistant.new
        @activity.errors[:id] << "activity with id #{params[:id]} not found"
        render json:  @activity.errors, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :description)
    end
end
