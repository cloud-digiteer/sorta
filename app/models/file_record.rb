class FileRecord < ApplicationRecord
  scope :search_by_filename, ->(query) {
    where("filename ILIKE ?", "%#{query}%") if query.present?
  }

  scope :sorted_by_created_at, ->(direction = "desc") {
    order(created_at: direction)
  }
end
