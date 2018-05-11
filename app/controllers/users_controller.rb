class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :login
  before_action :set_user, only: [:show, :curl, :edit, :update, :destroy, :post_update, :tor, :blacklist]
  skip_before_filter :require_no_authentication, :only => [:new, :create]

  def index
    @head_type = 0
    @ruby_or_curl = 0
  end

  def show
    @ruby_or_curl = 0
    @auth_token = @user.auth_token
  end

  def curl
    @ruby_or_curl = 1
    @auth_token = @user.auth_token
    render 'show'
  end

  def demo
    # demo user will be of id: 2
    # don't forget doing $rake db:seed
    @user = User.find_by(id: 2)
    @ruby_or_curl = 0
    @demo = 1
    # auth_token for demo user
    @auth_token = "sign_in_to_get_your_token"
    render 'show'
  end

  def demo_curl
    @user = User.find_by(id: 2)
    @demo = 1
    @ruby_or_curl = 1
    @auth_token = "sign_in_to_get_your_token"
    render 'show'
  end

  def api
    if params[:ip] != nil
      if @user.ips.exists?(a: params[:ip])
        @y = 1
      else
        @y = 0
      end
    end

    respond_to do |f|
      f.html { @user }
      f.json { render json: @y, status: 200 }
    end
  end

  def tor
    if params[:b] == "0" # set blocking OFF
      @user.tor = 0
      @user.save!

      Userip.joins(:ip).joins(:user).where(
        'ips.p' => 0,'users.id' => @user.id
      ).delete_all
      flash[:notice] = "Tor browser - UNBLOCKING"

    elsif params[:b] == "1" # set blocking ON
      @user.tor = 1
      @user.save!

      inserts = []
      Ip.where(p: 0).each{|ip| inserts.push "(#{@user.id}, #{ip.id})"}
      sql = 'INSERT INTO userips ("user_id", "ip_id") VALUES' + inserts.join(", ").to_s
      ActiveRecord::Base.connection.execute sql
      flash[:notice] = "Tor browser - BLOCKING"

    end

    render 'pref.js'

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # if @user.save
    #   Mailer.sendmail_confirm(@user).deliver
    # end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Welcome!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user == current_user
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User settings are updated' }
          format.json { render :show, status: :ok, location: @user }
          format.js
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user
      reset_session
      user = User.find(@user_id)
      user.destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'Your accout was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def current_user_home
    if user_signed_in?
      redirect_to current_user
    else
      redirect_to users_path
    end
  end

  private
  def login
    if session[:user_id].blank?
      user = User.create
      session[:user_id] = user.id
    end
    @user_id = session[:user_id]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:ip, :b, :user_name, :password, :email, :image_user)
  end
end
