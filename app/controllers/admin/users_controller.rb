class Admin::UsersController < ApplicationController
   def show
    @user = User.find(params[:id])
    @posts = @user.posts
   end

   def edit
      @user = User.find(params[:id])
   end

  def unsubscribe
     @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    #新規会員登録画面に遷移
    redirect_to admin_user_path(@user)
  end
end
