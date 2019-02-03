class User < ApplicationRecord
  has_many :learn_tips 
  has_many :lessons, through: :learn_tips

  has_secure_password 
end
