class FileRecordsController < ApplicationController

  def index
    puts params
    @query = params[:query]
    @sort_order = params[:sort].presence || "desc"
    @file_records = FileRecord.sorted_by_created_at(@sort_order)
    @months = Date::MONTHNAMES.compact.each_with_index.map { |month, i| [month, i + 1] }

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
      @file_records = FileRecord.sorted_by_created_at("desc")
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "file_records",
            partial: "file_records/table",
            locals: { file_records: @file_records }
          )
        end
        format.html { redirect_to file_records_path, notice: "File added successfully." }
      end
    else
      puts "================ERROR=================="
      puts @file_record.errors.full_messages.join(", ")
    end
  end

  def destroy
    @file_record = FileRecord.find(params[:id])
    @file_record.destroy
    redirect_to file_records_path, notice: "File deleted successfully."
  end

  private

  def file_record_params
    params.require(:file_record).permit(:filename)
  end

end
