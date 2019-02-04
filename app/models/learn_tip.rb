class LearnTip < ApplicationRecord
belongs_to :user 
belongs_to :lesson 

validates :link, presence: true, length: {maximum: 255}
validates :name, presence: true, length: {maximum: 255}



end
