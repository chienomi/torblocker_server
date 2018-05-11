module V1
  class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def api
      # input:
      # ip (string): IP address

      # output:
      # return 0 if IP address is not on the torblocker list
      # return 1 if IP address is on the torblocker list

      authenticate

      @y = 0 # output

      if params[:ip] != nil
        ip = Ip.find_by(a: params[:ip])
        if @user.ips.exists?(a: params[:ip])
          @y = 1
          # this ip should be blocked. write a log to user.history
          if @user.history.size > 50
            @user.history.shift
            @user.history << [ip.id, 0.day.ago]
          else
            @user.history << [ip.id, 0.day.ago]
          end
          @user.save!
        end
      end

      respond_to do |f|
        f.json { render json: @y, status: 200 }
      end
    end

    private
    def user_params
      params.require(:user).permit(:ip)
    end

    protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @user = User.find_by(auth_token: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Users"'

      respond_to do |format|
        format.json { render json: 'Bad credentials', status: 401 }
      end
    end
  end
end
