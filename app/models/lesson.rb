class Lesson < ApplicationRecord
    has_many :learn_tips
    has_many :users, through: :learn_tips
end
