class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

  def unsubscribe
  end

  def withdraw
    # @customerをcurrent_customerに変更
    current_user.update(is_active: false)
    reset_session
    redirect_to admin_about_path
  end


  private

  def user_params
    params.require(:user).permit(:nick_name, :introduction)
  end



end
