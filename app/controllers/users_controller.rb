class UsersController < ApplicationController
  before_action :require_login, except: [:index, :new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]  
  
  def index
    session.clear
  end

  def new
  end

  def create
    user = User.new(params[:user].permit(:name, :email, :password, :password_confirmation))
    if user.save
      session[:user_id] = user.id
      # flash[:success_message] = "Successfully registered. Please log in!"
      redirect_to user
    else
      flash[:error_messages] = user.errors.full_messages
      redirect_to '/users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    User.find(params[:id]).update(params[:user].permit(:name, :email))
    redirect_to '/users/' + params[:id].to_s 
  end

  def show
    @user = User.find(params[:id])
    @secrets = @user.secrets
  end

  def destroy
    @user = User.find(params[:id]).destroy
    session.clear
    redirect_to '/users/new'
  end
end
