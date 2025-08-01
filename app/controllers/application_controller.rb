class ApplicationController < ActionController::Base
  respond_to :html, :turbo_stream

  private

  def after_sign_in_path_for(resource)
    file_records_path
  end

  def after_sign_up_path_for(resource)
    file_records_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
