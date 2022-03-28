class TasksController < ApplicationController
  before_action :set_user
  
  def index
    @tasks = @user.tasks
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.new(task_params)
    if @task.save
      flash[:success] = "タスクを新規登録しました。"
      redirect_to user_tasks_path @user
      
    else
      render :new
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
    # 更新に成功した場合の処理を記述する。
    flash[:success] = "タスクを更新しました。"
    redirect_to user_task_url @user
    else
      render :edit
    end
  end

  private
  
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
