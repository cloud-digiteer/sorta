class FileRecord < ApplicationRecord
  scope :sorted_by_created_at, ->(direction = "desc") {
    order(created_at: direction)
  }

end
