class Book < ActiveRecord::Base
  belongs_to :author
  has_many :favorites

  validates :book_title, :author_id, :published_year, :presence => true

end
