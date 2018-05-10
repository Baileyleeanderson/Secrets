class SecretsController < ApplicationController
  def index
    @secrets =Secret.all
    
  end

  def like
    @user = User.find[session[:user_id]]
    @likes = User.join(:secret).where(user: @user)
  end

  def create
    @user = User.find(session[:user_id])
    @secret = Secret.new(content:params[:content], user: @user)
    @secret.save
    redirect_to "/users/#{@user.id}"
  end

  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy
    redirect_to "/users/#{session[:user_id]}"
  end
end
