class PasswordResetsController < ApplicationController

  before_action :require_no_authentication
  before_action :set_user, only: %i[edit update]

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordResetMailer.with(user: @user).reset_email.deliver_later
      @user.set_password_reset_token
    end

    flash[:success] = t('.success')
    redirect_to new_session_path, status: :unprocessable_entity
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = t '.success'
      redirect_to new_session_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end

  def set_user
    @user = User.find_by(email: params[:user][:email])
    # byebug
    redirect_to(new_session_path, flash: { warning: t('.fail') }) unless @user&.password_reset_period_valid?
  end

end