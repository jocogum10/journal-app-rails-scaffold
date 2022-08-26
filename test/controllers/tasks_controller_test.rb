require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  def login_then_create_category
    post user_session_path
    sign_in users(:admin)
    post user_session_url
    @category = Category.create(name: "test category", details: "details of test category")
  end
  # def second_setup
  #   post user_session_path
  #   sign_in users(:admin)
  #   post user_session_url
  #   @category = Category.create(name: "test category", details: "details of test category")
  # end

  test "4. create a task for a specific category" do
    login_then_create_category
    post category_tasks_path(@category.id), params: {task: {name: "First task", details: "details of the task", category_id: @category.id}}
    assert_redirected_to category_tasks_path
  end

  test "5. edit a task to update task's details" do
    login_then_create_category
    @category.tasks.create(name: "test number 5", details: "details test number 5")
    task = @category.tasks.find_by(name: "test number 5")
    patch category_task_path(@category.id, task.id),  params: {task: {name: "test task edited", details: "details test task edited", category_id: @category.id}}
    assert_redirected_to category_tasks_path
  end

  test "6. view a task to show task's details" do
    login_then_create_category
    @category.tasks.create(name: "test number 6", details: "details test task for number 6")
    task = @category.tasks.find_by(name: "test number 6")
    get category_task_path(@category.id, task.id)
    assert_response :success
  end

  test "7. delete a task to lessen my unnecessary daily tasks" do
    login_then_create_category
    @category.tasks.create(name: "test number 7", details: "details test task for number 6")
    task = @category.tasks.find_by(name: "test number 7")
    delete category_task_path(@category.id, task.id)
    assert_redirected_to category_tasks_path
  end
  
  test "8. view my tasks for today" do
    login_then_create_category
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

  test "9. create my account" do
    post user_registration_path
    sign_in users(:admin)
    assert_response :success
  end

  test "10. login my account" do
    post user_session_path
    sign_in users(:admin)
    post user_session_url
    assert_redirected_to root_path
  end

end
