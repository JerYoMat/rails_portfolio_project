class User < ApplicationRecord
  has_many :learn_tips 
  has_many :lessons, through: :learn_tips

  has_secure_password 

  def User.digest(string)  #needed to set up fixtures/users.yml Uses low 
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
