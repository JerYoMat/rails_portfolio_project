class User < ApplicationRecord
  has_many :learn_tips 
  has_many :lessons, through: :learn_tips

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :name, :email
  validates :name, length: {maximum: 255}
  validates :email, length: {maximum: 255}, uniqueness: {case_sensitive: false}, format: { with: EMAIL_REGEX}
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :has_graduated, inclusion: { in: [true, false] }
  has_secure_password 


  def User.digest(string)  #needed to set up fixtures/users.yml Uses low 
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
