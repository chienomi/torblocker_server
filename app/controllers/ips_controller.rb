class IpsController < ApplicationController
  before_action :set_ip, only: [:show, :edit, :update, :destroy]

  # GET /ips
  def index
    @ips = Ip.all
  end

  # GET /ips/1
  def show
  end

  # GET /ips/new
  def new
    @ip = Ip.new
  end

  # GET /ips/1/edit
  def edit
  end

  # POST /ips
  def create
    @ip = Ip.new(ip_params)

    if @ip.save
      redirect_to @ip, notice: 'Ip was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ips/1
  def update
    if @ip.update(ip_params)
      redirect_to @ip, notice: 'Ip was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ips/1
  def destroy
    @ip.destroy
    redirect_to ips_url, notice: 'Ip was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ip
    @ip = Ip.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def ip_params
    params.require(:ip).permit(:a, :d, :s)
  end
end
