require 'test_helper'
#General principals
#Unknown users get sent to login
#Unauthorized actions get sent to root or just verify that nothing has changed

class LearnTipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @learn_tip = learn_tips(:learn_tip_1)
    @user = users(:test_user_michael)
    @other_user = users(:test_user_angelo)
    @new_learn_tip = LearnTip.create(name: "new tip test name",
                                     link: "www.somethingawesome.com",
                                     description: "a great resources for mastering X",
                                     lesson_id: 1,
                                     user_id: 1)
    def save_new_tip
      @new_learn_tip.user = @user 
      @new_learn_tip.save 
    end 

  end

  test "should get index" do
    get learn_tips_url
    assert_response :success
  end

  test "logged in user can get new" do
    log_in_as(@user)
    get new_learn_tip_url
    assert_response :success
  end

  test "unknown user cannot get new" do
    get new_learn_tip_url
    assert_redirected_to login_path
  end

  test "Current user can create learn_tip" do
    log_in_as(@user)
    assert_difference('LearnTip.count') do
      post learn_tips_url, params: { learn_tip: { name: @new_learn_tip.name,
                                                  link: @new_learn_tip.link,
                                                  description: @new_learn_tip.description,
                                                  lesson_id: @new_learn_tip.lesson_id,
                                                  user_id: @user.id } }
    end
    assert_redirected_to lesson_learn_tip_url(Lesson.find(@new_learn_tip.lesson_id))
  end

  test "Unknown user cannot create learn_tip" do
    assert_no_difference('LearnTip.count') do
      post learn_tips_url, params: { learn_tip: { name: @new_learn_tip.name,
                                                  link: @new_learn_tip.link,
                                                  description: @new_learn_tip.description,
                                                  lesson_id: @new_learn_tip.lesson_id,
                                                  user_id: nil} }
    end
    assert_redirected_to login_path
  end

  test 'cannot create learn_tip for different user' do 
    log_in_as(@user)
    assert_no_difference('LearnTip.count') do
      post learn_tips_url, params: { learn_tip: { name: @new_learn_tip.name,
                                                  link: @new_learn_tip.link,
                                                  description: @new_learn_tip.description,
                                                  lesson_id: @new_learn_tip.lesson_id,
                                                  user_id: @other_user.id } }
    end
    assert_redirected_to root_path
  end 

  test "should show learn_tip" do
    get learn_tip_url(@learn_tip)
    assert_response :success
  end

  test "owning user can get edit" do
    save_new_tip
    log_in_as(@user)
    get edit_learn_tip_url(@learn_tip)
    assert_response :success
  end

  test "different user cannot get edit" do 
    save_new_tip
    log_in_as(@other_user)
    get edit_learn_tip_url(@learn_tip)
    assert_redirected_to root_path
  end 

  test "unknown user cannot get edit" do 
    save_new_tip
    get edit_learn_tip_url(@learn_tip)
    assert_redirected_to login_path
  end

  test "owning user can update learn_tip" do
    save_new_tip
    log_in_as(@user)
    patch learn_tip_url(@new_learn_tip), params: { learn_tip: { name: @new_learn_tip.name,
                                                                link: @new_learn_tip.link,
                                                                description: @new_learn_tip.description,
                                                                lesson_id: @new_learn_tip.lesson_id,
                                                                user_id: @user.id } }
    assert_redirected_to learn_tip_url(@learn_tip)
  end

  test "different user cannot update learn_tip" do
    save_new_tip
    log_in_as(@other_user)
    patch learn_tip_url(@new_learn_tip), params: { learn_tip: { name: @new_learn_tip.name,
                                                                link: @new_learn_tip.link,
                                                                description: "NEW DESCRIPTION",
                                                                lesson_id: @new_learn_tip.lesson_id,
                                                                user_id: @user.id } }
    assert_not @new_learn_tip.description, "NEW DESCRIPTION"
  end

  test "unknown user cannot update learn_tip" do
    save_new_tip
    patch learn_tip_url(@new_learn_tip), params: { learn_tip: { name: @new_learn_tip.name,
                                                                link: @new_learn_tip.link,
                                                                description: "NEW DESCRIPTION",
                                                                lesson_id: @new_learn_tip.lesson_id,
                                                                user_id: @user.id } }
    assert_not @new_learn_tip.description, "NEW DESCRIPTION"
  end



  test "owning user can destroy" do
    save_new_tip
    log_in_as(@user)
    assert_difference('LearnTip.count', -1) do
      delete learn_tip_url(@learn_tip)
    end
    assert_redirected_to root_path
  end

  test "different user cannot destroy" do
    save_new_tip
    log_in_as(@other_user)
    assert_no_difference('LearnTip.count', -1) do
      delete learn_tip_url(@learn_tip)
    end
    assert_redirected_to root_path
  end

  test "Unknown user cannot destroy" do
    save_new_tip
    assert_no_difference('LearnTip.count', -1) do
      delete learn_tip_url(@learn_tip)
    end
    assert_redirected_to root_path
  end

end
