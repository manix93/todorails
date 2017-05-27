class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new(finished: false)
  end

  def create
    @task = Task.new(task_params)
    @task.save
    flash[:notice] = "Dodałeś TUska"
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :finished)
  end
end
