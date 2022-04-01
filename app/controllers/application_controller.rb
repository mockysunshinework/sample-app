class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #before フィルター
    # paramsハッシュからユーザーを取得する。
    def set_user
    @user = User.find(params[:id])
    end
    
    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to root_url unless current_user?(@user)
    end
    
    # システム管理権限所有化どうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    # 管理者権限、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
      flash[:danger] = "編集権限がありません。"
      redirect_to root_url
      end
    end
  
end
