class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category
  # skip_before_action :get_category, only: [:today]

  def index
    @tasks = @category.tasks
  end

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build(task_params)

    if @task.save
      redirect_to category_tasks_path
    else
      render :new
    end
  end

  def edit
    @task = @category.tasks.find(params[:id])
  end

  def update
    @task = @category.tasks.find(params[:id])
    @task.update(name: params[:task][:name], details: params[:task][:details])
    redirect_to category_tasks_path
  end

  def show
    @task = @category.tasks.find(params[:id])
  end

  def destroy
    @task = @category.tasks.find(params[:id])
    @task.destroy
    redirect_to category_tasks_path
  end

  def today
    # @tasks = Task.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
    @tasks = @category.tasks.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
  end

  private

  def get_category
    @category = Category.find(params[:category_id])
  end

  def task_params
    params.require(:task).permit(:name, :details, :category_id)
  end

end
