class SessionsController < ApplicationController
    # before_action :require_login, except: [:new, :create]
    # before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

    def new
        render 'new'
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            puts session[:user_id]
            puts "\n\n\n\n"
            redirect_to "/users/#{session[:user_id]}"
        else
            redirect_to "/sessions/new"
            flash[:messages] = 'Invalid Combination'
        end
    end

    def destroy
       session.clear
       redirect_to '/sessions/new'
    end
end
