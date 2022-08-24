require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = Category.create(name: "test category", details: "details of test category")
  end

  test "4. create a task for a specific category" do
    post category_tasks_path(@category.id), params: {task: {name: "First task", details: "details of the task", category_id: @category.id}}
    assert_redirected_to category_tasks_path
  end

  test "5. edit a task to update task's details" do
    @category.tasks.create(name: "test number 5", details: "details test number 5")
    task = @category.tasks.find_by(name: "test number 5")
    patch category_task_path(@category.id, task.id),  params: {task: {name: "test task edited", details: "details test task edited", category_id: @category.id}}
    assert_redirected_to category_tasks_path
  end

  test "6. view a task to show task's details" do
    @category.tasks.create(name: "test number 6", details: "details test task for number 6")
    task = @category.tasks.find_by(name: "test number 6")
    get category_task_path(@category.id, task.id)
    assert_response :success
  end

  test "7 .delete a task to lessen my unnecessary daily tasks" do
    @category.tasks.create(name: "test number 7", details: "details test task for number 6")
    task = @category.tasks.find_by(name: "test number 7")
    delete category_task_path(@category.id, task.id)
    assert_redirected_to category_tasks_path
  end
  
end
