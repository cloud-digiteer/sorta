class FileRecord < ApplicationRecord
  has_one_attached :file
  validates :file, presence: true 
  before_save :set_filename

  scope :sorted_by_created_at, ->(direction = "desc") {
    order(created_at: direction)
  }

end
