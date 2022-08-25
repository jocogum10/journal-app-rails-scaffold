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

  test "7. delete a task to lessen my unnecessary daily tasks" do
    @category.tasks.create(name: "test number 7", details: "details test task for number 6")
    task = @category.tasks.find_by(name: "test number 7")
    delete category_task_path(@category.id, task.id)
    assert_redirected_to category_tasks_path
  end
  
  test "8. view my tasks for today" do
    @category.tasks.create(name: "test number 8 first", details: "details test task for number 8")
    @category.tasks.create(name: "test number 8 second", details: "details test task for number 8")
    @category.tasks.create(name: "test number 8 third", details: "details test task for number 8")
    @category.tasks.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
    get tasks_today_path(@category.id)
    assert_select "tbody" do |elements|
      elements.each do |element|
        assert_select element, "tr", 3
      end
    end
  end

end
