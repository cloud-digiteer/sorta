require "test_helper"

class FileRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get file_records_index_url
    assert_response :success
  end

  test "should get create" do
    get file_records_create_url
    assert_response :success
  end
end
