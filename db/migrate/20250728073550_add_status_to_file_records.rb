class AddStatusToFileRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :file_records, :status, :string
  end
end
