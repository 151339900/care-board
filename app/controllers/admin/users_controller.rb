class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

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
    #新規会員登録画面に遷移
    redirect_to admin_posts_path
  end
end
