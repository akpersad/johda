class Category < ActiveRecord::Base
  has_many :order_catagories
  belongs_to :order

  # Temporary alias for misspelled foreign key usage in join table
  def self.table_name
    'categories'
  end
end


