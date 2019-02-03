test_user_michael = User.create!(
    name: "Michael",
    email: "first_user@test.com",
    password: "password",
    password_confirmation: "password",
    has_graduated: true 
)

test_user_angelo = User.create!(
    name: "Angelo",
    email: "second_user@test.com",
    password: "password",
    password_confirmation: "password",
    has_graduated: false  
)


10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+2}@testusers.org"
    password = "password"
    has_graduated = rand() > 0.5 ? true : false  
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 has_graduated: has_graduated
                 )
  end
  
  
  
  
  lesson_topics = ["Ruby Basics", "Git and Github", "OO Ruby", "SQL", "ORM and ActiveRecord", "Rack and Middleware", "Sinatra", "Rails", "Javascript Basics", "Working with DOM", "CSS", "Job Hunt"]
  
  index = 0 
  while (index < lesson_topics.length)
    fake_description = Faker::Lorem.paragraph(sentence_count = 5)
    name = lesson_topics[index]
    Lesson.create!(
              name: name, content: fake_description, order: index + 1)
    index+=1
  end 
  
  
  
 
  8.times do
    
    name = Faker::Lorem.sentence(2)
    description = Faker::Lorem.sentence(5)
    link = Faker::Internet.url
    user_benefit = "yay"
    User.all.each { |user| user.learn_tips.create!(
      name: name,
      description: description,
      link: link,
      lesson_id: rand(12)+1) }
  end