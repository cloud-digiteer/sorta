class CreateFileRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :file_records do |t|
      t.string :filename
      t.string :string

      t.timestamps
    end
  end
end
