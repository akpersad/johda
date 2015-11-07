class AverageCache < ActiveRecord::Base
  belongs_to :rater, :class_name => "Comment"
  belongs_to :rateable, :polymorphic => true
end
