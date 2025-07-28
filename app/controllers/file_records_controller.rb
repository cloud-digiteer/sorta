class FileRecordsController < ApplicationController
  def index
    @query = params[:query]
    @file_records = FileRecord.search(@query).with_attached_file
  end

  def create
    @file_record = FileRecord.new(file_record_params)
    if @file_record.save
      redirect_to file_records_path, notice: "File uploaded successfully."
    else
      redirect_to file_records_path, alert: "Failed to upload file."
    end
  end

  def destroy
    @file_record = FileRecord.find(params[:id])
    @file_record.destroy
    redirect_to file_records_path, notice: "File deleted successfully."
  end

  private
  def file_record_params
    params.require(:file_record).permit(:file)
  end
end
