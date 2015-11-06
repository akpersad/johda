class MenuComment < ActiveRecord::Base
	acts_as_commentable
	ratyrate_rateable "rating"
  validates :merch_id, uniqueness: true
end
