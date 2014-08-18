class Quizz < ActiveRecord::Base
  validates_presence_of :question,:ans1, :ans2, :ans3, :ans4, :correctans
  validates_numericality_of :correctans
end
