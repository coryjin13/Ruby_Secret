class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
  	@all_secrets = Secret.all
 	  @user_id = session[:user_id]
  	# @user_secrets = User.find(@user_id).secrets.all
  end
  def create
  	secret = User.find(params[:id]).secrets.new(params[:secret].permit(:content, :user_id))
  	# secret = User.find(session[:user_id]).secrets.new(params[:secret].permit(:content, :user_id))
  	secret.save
  	redirect_to '/users/' + params[:id].to_s 
  	  	# redirect_to '/users/' + session[:user_id].to_s 
  end
  def destroy
  	secret = Secret.find(params[:id]).destroy
    secret.destroy if secret.user == current_user
  	redirect_to '/users/' + session[:user_id].to_s 
  	# redirect_to '/users/' + params[:id].to_s       #does not work
  end

  private
    def secret_params
      params.require(:secret).permit(:content)
    end
end
