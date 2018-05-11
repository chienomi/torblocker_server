class UseripsController < ApplicationController
  before_action :set_userip, only: [:show, :edit, :update, :destroy]

  # GET /userips
  def index
    @userips = Userip.all
  end

  # GET /userips/1
  def show
  end

  # GET /userips/new
  def new
    @userip = Userip.new
  end

  # GET /userips/1/edit
  def edit
  end

  # POST /userips
  def create
    @userip = Userip.new(userip_params)

    if @userip.save
      redirect_to @userip, notice: 'Userip was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /userips/1
  def update
    if @userip.update(userip_params)
      redirect_to @userip, notice: 'Userip was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /userips/1
  def destroy
    @userip.destroy
    redirect_to userips_url, notice: 'Userip was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_userip
    @userip = Userip.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def userip_params
    params.require(:userip).permit(:user_id, :ip)
  end
end
