require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = Category.create(name: "test category", details: "details of test category")
  end

  test "4. create a task for a specific category" do
    task = @category.tasks.create(name: "First task", details: "details of the task", category_id: @category.id)
    assert task.save, "Task is saved"
  end

  test "5. edit a task to update task's details" do
    @category.tasks.create(name: "test number 5", details: "details test number 5")
    task = @category.tasks.find_by(name: "test number 5")
    assert task.update(name: "test task edited", details: "details test task edited", category_id: @category.id), "Edited a task"
  end
end
