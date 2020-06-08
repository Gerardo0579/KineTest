class Api::AssistantsController < ApplicationController
  before_action :set_assistant, only: [:show, :update, :destroy]

  # GET /assistants
  # GET /assistants.json
  def index
    @assistants = Assistant.all
    render :index
  end

  # GET /assistants/1
  # GET /assistants/1.json
  def show
    render :show
  end

  # POST /assistants
  # POST /assistants.json
  def create
    @assistant = Assistant.new(assistant_params)

    if @assistant.save
      render :show, status: :created, location: @assistant
    else
      render json: @assistant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assistants/1
  # PATCH/PUT /assistants/1.json
  def update
    if @assistant.update(assistant_params)
      render :show, status: :ok, location: @assistant
    else
      render json: @assistant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /assistants/1
  # DELETE /assistants/1.json
  def destroy
    @assistant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assistant
      begin
        @assistant = Assistant.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @assistant = Assistant.new
        @assistant.errors[:id] << "assistant with id #{} not found"
        render json: @assistant.errors, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def assistant_params
      params.require(:assistant).permit(:name, :group, :address, :phone)
    end
end
