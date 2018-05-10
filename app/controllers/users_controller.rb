class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create]
    before_action :require_current_user, only: [:show, :edit, :update, :destroy]

    def index
    end

    def new
        puts 'made it'
        render 'new'
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password)) 
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to "/sessions/new"
        else 
            flash[:messages] = "can't be blank"
            redirect_to '/users/new'
        end
    end

    def show
        @user = User.find(session[:user_id])
        @secrets = Secret.all
        @user_secrets = @user.secrets
    end

    def edit
        @user = User.find(session[:user_id])
        render 'edit'
    end

    def update
        user = User.find(session[:user_id])
        user.name = params[:name]
        user.email = params[:email]
        if user.valid?
            user.save
            flash[:messages] = user.name
            redirect_to "/users/#{session[:user_id]}"
        else
            flash[:messages] = "Email is invalid"
            redirect_to "/users/#{session[:user_id]}/edit"
        end   
    end

    def destroy
        session[:clear]
        redirect_to '/users/new'
    end
end

