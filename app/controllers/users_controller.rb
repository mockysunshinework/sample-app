class UsersController < ApplicationController
  
  before_action :set_user,only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,only: [:edit, :update]
  before_action :admin_user,only: [:destroy, :index]
  before_action :admin_or_correct_user,only: :show
  
  
  def index
  @users = User.paginate(page:params[:page],per_page: 20)
  end
  
  def show
  end

  def new
    if logged_in? && !current_user.admin?
      flash[:info] = "すでにログインしています。"
      redirect_to user_url(current_user)
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to user_url @user 
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to users_url 
  end


  private
  
      # paramsハッシュからユーザーを取得する。
    def set_user
    @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    
      
end
