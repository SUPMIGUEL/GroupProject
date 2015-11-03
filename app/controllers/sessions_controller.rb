class SessionsController < ApplicationController
    before_action :go_home, only: [:signup, :login]

    def signup
         @user = User.new 
    end

    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome, you are now logged in!"
            redirect_to root_path
        else
            render :signup
        end
    end

    def login

    end

    def attempt_login
        if params[:username].present? && params[:password].present?
            found_user = User.where(username: params[:username]).first
            if found_user
                authorized_user = found_user.authenticate(params[:password])
            end
        else
            empty = true
        end

        if empty
            flash[:notice] = "User or password can't be blank"
            redirect_to login_path
        elsif !found_user
            flash[:notice] = "Your user it's not correct!"
            redirect_to login_path
        elsif !authorized_user
            flash[:notice] = "Your password it's not correct!"
            redirect_to login_path
        else
            session[:user_id] = found_user.id
            redirect_to root_path
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "You are now log out"
        redirect_to root_path
    end

    def home
      
    end

    private

    def user_params
        params.require(:user).permit(
            :email,
            :username,
            :password,
            :password_confirmation,
            :picture,
            :bio,
            :contact_link
            )
    end

    def go_home
        if session[:user_id]
            redirect_to root_path
        end
    end
end 

    