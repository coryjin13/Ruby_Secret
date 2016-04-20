class SessionsController < ApplicationController

  def index
    @name = session[:name]
  end

  def new
    @user_id = session[:user_id]
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:name] = user.name
      redirect_to user
      # redirect_to user_path
    else
      flash[:errors] = "Invalid email/password combination!!"
      redirect_to new_session_path
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    # session[:user_id] = nil
    session.clear
    redirect_to new_session_path
  end
end
