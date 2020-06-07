class Api::BabiesController < ApplicationController
  before_action :set_baby, only: [:show, :update, :destroy]

  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.all
    render :index
  end

  # GET /babies/1
  # GET /babies/1.json
  def show
    render :show
  end

  # POST /babies
  # POST /babies.json
  def create
    @baby = Baby.new(baby_params)

    if @baby.save
      render :show, status: :created, location: @baby
    else
      render json: @baby.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /babies/1
  # PATCH/PUT /babies/1.json
  def update
    if @baby.update(baby_params)
      render :show, status: :ok, location: @baby
    else
      render json: @baby.errors, status: :unprocessable_entity
    end
  end

  # DELETE /babies/1
  # DELETE /babies/1.json
  def destroy
    @baby.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_baby
      @baby = Baby.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def baby_params
      params.require(:baby).permit(:name, :birth, :mother_name, :father_name, :address, :phone)
    end
end
