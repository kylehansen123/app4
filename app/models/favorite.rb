class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :book

  validates :book, :presence => true
  validates :user, :presence => true

end
