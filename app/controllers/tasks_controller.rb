class TasksController < ApplicationController
  def index
    if user_signed_in?
    @tasks = current_user.tasks
      if current_user.admin?
      @tasks = Task.all
      end
    end
  end

  def new
    @task = Task.new(finished: false, user_id: current_user.id)
  end

  def create
    @task = Task.new(task_params)
    @task.valid? ? create_task : handle_post_validation_failed
  end

  def show
  end

  def edit
    @task = Task.find(params[:id])
    @task.update_attributes(finished: true)
    flash[:notice] = "TUsk został skończony"
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :finished, :user_id)
  end

  def create_task
    current_user.tasks << @task
    flash[:notice] = "Dodałeś TUska"
    redirect_to root_path
  end

  def handle_post_validation_failed
    flash[:errors] = @task.errors.full_messages
    redirect_back(fallback_location: root_path)
  end
end
