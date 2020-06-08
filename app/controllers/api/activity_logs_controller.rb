class Api::ActivityLogsController < ApplicationController
  before_action :set_activity_log, only: [:show, :update, :destroy]
  before_action :set_related_id, only: [:index]

  # GET /activity_logs
  # GET /activity_logs.json
  def index
    render :json => { :error => "id #{@id} not found", :status => 404} unless @error.nil?

    if @id.nil?
      @activity_log = ActivityLog.all
      render :index
    elsif @id == "0"
      @activity_log = ActivityLog.all.joins(:activity, :assistant, :baby)
                        .select("activity_logs.id, 
                                 activity_logs.baby_id, 
                                 activity_logs.start_time, 
                                 activity_logs.stop_time,
                                 babies.name as baby_name, 
                                 activities.name as activity_name, 
                                 assistants.name as assistant_name")
      
      render :index_related
    else
      @activity_log = ActivityLog.where(baby_id: @id)
                        .joins(:activity, :assistant)
                        .select("activity_logs.id, 
                                 activity_logs.baby_id, 
                                 activity_logs.start_time, 
                                 activity_logs.stop_time, 
                                 activities.name as activity_name, 
                                 assistants.name as assistant_name")

      render :index_related

    end

  end

  # GET /activity_logs/1
  # GET /activity_logs/1.json
  def show
    render :json => { :error => "id #{@id} not found", :status => 404} unless @error.nil?
    render :show if @error
  end

  # POST /activity_logs
  # POST /activity_logs.json
  def create
    @activity_log = ActivityLog.new(activity_log_params)

    if @activity_log.save
      render :show, status: :created
    else
      render json: @activity_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activity_logs/1
  # PATCH/PUT /activity_logs/1.json
  def update
    if @activity_log.update(activity_log_params_patch)
      render :show, status: :ok
    else
      render json: @activity_log.errors, status: :unprocessable_entity
    end
    
  end

  # DELETE /activity_logs/1
  # DELETE /activity_logs/1.json
  def destroy
    @activity_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_log
      begin
        @id = params[:id]
        @activity_log = ActivityLog.find(@id)
      rescue ActiveRecord::RecordNotFound
        @error = true
      end
    end

    def set_related_id
      begin
        @id = params[:baby_id]
      rescue ActiveRecord::RecordNotFound
        @error = true
      end
    end

    # Only allow a list of trusted parameters through.
    def activity_log_params_patch
      params.require(:activity_log).permit(:stop_time,:comments)
    end

    def activity_log_params
      params.require(:activity_log).permit(:start_time,:baby_id, :assistant_id, :activity_id)
    end
end
