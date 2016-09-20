class TasksController < ApplicationController
  before_action :authenticate!

  def index
    @tasks = Task.all.order("created_at DESC")
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = "You've created a new task."
      redirect_to tasks_path
    else
      flash[:danger] = @task.errors.full_messages
      redirect_to new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.complete
      if @task.update(complete: false)
        flash[:success] = "You've marked the task as undone."
        redirect_to tasks_path
      else
        flash[:danger] = @task.errors.full_messages
        redirect_to edit_task_path(@task)
      end
    else
      if @task.update(complete: true)
        flash[:success] = "You've marked the task as done."
        redirect_to tasks_path
      else
        flash[:danger] = @task.errors.full_messages
        redirect_to edit_task_path(@task)
      end
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.destroy
      flash[:success] = "You've deleted the task."
      redirect_to tasks_path
    else
      flash[:danger] = @task.errors.full_messages
      redirect_to task_path(@task)
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :complete)
  end
end
