class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      sign_in(user)
      remember(user) if params[:remember_me] == "1"
      flash[:success] = "Welcome back, #{user.decorate.name_or_email}"
      redirect_to questions_path
    else
      flash.now[:warning] = "Incorrect email and/or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    forget(current_user)
    sing_out
    flash[:success] = 'See yuo later!'
    redirect_to root_path
  end
end