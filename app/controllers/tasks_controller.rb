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
      flash.now[:alert] = "タスク作成に失敗しました"
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスク更新成功!"
      redirect_to task_path(@task.id)
    else
      flash.now[:alert] = "タスク更新失敗!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = "タスク削除成功!"
      redirect_to authenticated_root_path
    else
      flash.now[:alert] = "タスク削除失敗!"
      render :show, status: :unprocessable_entity
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :description)
  end

end
