class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:notice] = "タスクを作成しました"
      redirect_to task_path(@task.id)
    else
      flash.now[:notice] = "タスク作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @tasks = current_user.tasks.order(created_at: :asc)
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :description)
  end

end
