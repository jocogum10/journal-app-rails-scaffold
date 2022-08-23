require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = Category.create(name: "first category", details: "details of first category")
  end

  test "4. create a task for a specific category" do
    post category_tasks_path(@category.id), params: {task: {name: "First task", details: "details of the task", category_id: @category.id}}
    assert_redirected_to category_tasks_path
  end

  test "5. edit a task to update task's details" do
    patch category_task_path(@category.id)
  end
end
