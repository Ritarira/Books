class Book < ApplicationRecord
  belongs_to :author

  validates :author, presence: true
  validates :title, presence: true
end
