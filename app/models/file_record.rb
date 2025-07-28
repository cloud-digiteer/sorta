class FileRecord < ApplicationRecord
  has_one_attached :file
  validates :file, presence: true 
  before_save :set_filename

  scope :search, ->(query) {
    where("filename ILIKE ?", "%#{query}%") if query.present?
  }

  private

  def set_filename
    self.filename = file.filename.to_s if file.attached?
  end

end
