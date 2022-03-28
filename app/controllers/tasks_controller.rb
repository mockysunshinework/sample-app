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
      redirect_to user_tasks_path(@user)
      
    else
      render :new
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
