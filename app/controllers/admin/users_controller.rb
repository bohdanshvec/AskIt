# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :require_authentication
  before_action :set_user!, only: %i[destroy]

  def index
    respond_to do |format|
      format.html do
        @pagy, @users = pagy(User.ordered)
      end

      format.zip do
        respond_with_zipped_users
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    if params[:archive].present?
      UserBulkService.call(params[:archive])
      flash[:success] = 'User imported!'
      redirect_to admin_users_path
    else
      @user = User.new(user_params)

      if @user.save
        flash[:success] = 'User created!'
        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user.delete
    flash[:success] = 'User deleted!'
    redirect_to admin_users_path, status: :see_other
  end

  private

  def respond_with_zipped_users
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user_#{user.id}.xlsx"
        zos.print render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'admin/users/user', locals: { user: user }
        )
      end
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: 'users.zip'
  end

  def set_user!
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end