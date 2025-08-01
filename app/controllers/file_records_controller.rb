class FileRecordsController < ApplicationController

  def index
    @query = params[:query]
    @sort_order = params[:sort].presence || "desc"
    @file_records = FileRecord.search_by_filename(@query).sorted_by_created_at(@sort_order)
    @months = Date::MONTHNAMES.compact

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
      puts "=== SUBMIT SUCCESS ==="
      load_file_records

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "file_records",
              partial: "file_records/table",
              locals: { file_records: @file_records }
            ),
            turbo_stream.replace(
              "new_file_form",
              partial: "file_records/form",
              locals: { file_record: FileRecord.new }
            )
          ]
        end
      end
    else
      puts "===================== FILENAME CREATION ERROR ======================="
    end
  end

  def destroy
    @file_record = FileRecord.find(params[:id])
    @file_record.destroy

    respond_to do |format|
      format.turbo_stream do
        load_file_records
        render turbo_stream: turbo_stream.replace("file_records", partial: "file_records/table", locals: { file_records: @file_records })
      end
      format.html { redirect_to file_records_path, notice: "File deleted." }
    end
  end

  def toggle_status
    @file_record = FileRecord.find(params[:id])
    @file_record.status = @file_record.status == "for_signed" ? "approved" : "for_signed"
    @file_record.save
    load_file_records

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "file_records",
          partial: "file_records/table",
          locals: { file_records: @file_records }
        )
      end
      format.html { redirect_to file_records_path, notice: "Status updated." }
    end
  end

  private

  def file_record_params
    params.require(:file_record).permit(:filename)
  end

  def load_file_records
    @file_records = FileRecord.sorted_by_created_at("desc")
  end

end
