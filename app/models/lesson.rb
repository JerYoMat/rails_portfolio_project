class Lesson < ApplicationRecord
    has_many :learn_tips
    has_many :users, through: :learn_tips

   validates_presence_of :name, :content, :order

end
