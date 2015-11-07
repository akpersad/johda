class MenuComment < ActiveRecord::Base
	acts_as_commentable
  validates :merch_id, uniqueness: true
end
