require 'test_helper'

class LearnTipTest < ActiveSupport::TestCase
  
  def setup 
    @learn_tip = learn_tips(:learn_tip_1)
    @new_learn_tip = LearnTip.new(name: 'test learn tip',
                                     lesson_id: 1,
                                     user_id: 1,
                                     link: 'www.something.com',
                                     description: "asdfasdfasdfasdfasd. asdfasdfasdfasdfasdf asdfasdfasdfasdfasdf")
  end  
  
  
  test 'should be valid' do 
    assert @learn_tip.valid?
  end 
 
  test 'requires user' do 
    @new_learn_tip.user_id = nil 
    assert_not @new_learn_tip.save
  end 

  test 'requires lesson' do 
    @new_learn_tip.lesson_id = nil 
    assert_not @new_learn_tip.save
  end 

  test 'requires link' do 
    @new_learn_tip.link = nil 
    assert_not @new_learn_tip.save
  end 

  test 'link does not exceed length' do 
     @new_learn_tip.link = "a" * 257
     assert_not @new_learn_tip.save
  end 

  test 'name does not exceed length' do 
    @new_learn_tip.name = "a" * 257
    assert_not @new_learn_tip.save
  end 

end
