class FileRecordsController < ApplicationController
  def index
    puts params
    @query = params[:query]
    @sort_order = params[:sort]
    @file_records = FileRecord.with_attached_file.sorted_by_created_at(@sort_order)
    respond_to do |format|
      format.html
      format.turbo_stream do 
        render turbo_stream: turbo_stream.replace(
          "file_records", partial: "file_records/table", locals: {file_records: @file_records}
        )
      end
    end
  end

  def create
    @file_record = FileRecord.new(file_record_params)
    @file_record.status = "for_signed"
    
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
