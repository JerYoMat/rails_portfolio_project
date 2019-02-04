require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  setup do
    @lesson = lessons(:lesson_1)  
  end 

  test 'should be valid' do 
    assert @lesson.valid?
  end 
#In the current form the lesson instances are not editable and will not be created by users.  Limited validation being done at this time.  

end
