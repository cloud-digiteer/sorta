class FileRecord < ApplicationRecord
  scope :search_by_filename, ->(query) {
    where("filename ILIKE ?", "%#{query}%") if query.present?
  }

  scope :sorted_by_created_at, ->(direction = "desc") {
    order(created_at: direction)  
  }

  scope :by_month, ->(month_number) {
    where("EXTRACT(MONTH FROM created_at) = ?", month_number) if month_number.present? && month_number.to_i > 0
  }

  scope :search_by_filename, ->(query) {
    where("filename ILIKE ?", "%#{query}%") if query.present?
  }


end
