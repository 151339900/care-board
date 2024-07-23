# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end



  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

    def after_sign_in_path_for(resource)
      admin_about_path
    end

    def after_sign_out_path_for(resource)
      new_admin_session_path
    end
    
  private
    def user_status
      user = User.find_by(email: params[:user][:email])
      # 登録されていないemailの場合if文がtrueとなりreturnが実行される→ログインできず
      return if user.nil?
      # emailとパスワードの組み合わせが正しくない場合unless文がtrueとなりreturnが実行される→ログインできず
      return unless user.valid_password?(params[:user][:password])
      # is_activeカラムがtrue場合if文がtrueとなりcustomer_stateメソッドが実行完了となり、createアクションが実行される＝ログインできる
      if user.is_active == true
		    create
      else
		    # ここまで来るのは退会した人（emailは登録済み＋パスワードも正しい、けどis_activeがfalse）→再登録のためにサインアップ画面へ→メールアドレスが登録済みの場合、同じアドレスで会員登録は出来ないはず
  	    redirect_to new_user_registration_path
      end
    end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end