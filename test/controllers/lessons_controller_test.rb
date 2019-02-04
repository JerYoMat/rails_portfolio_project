require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson = lessons(:lesson_1)
  end

  test "should get index" do
    get lessons_url
    assert_response :success
  end

  test "should show lesson" do
    get lesson_url(@lesson)
    assert_response :success
  end
end
