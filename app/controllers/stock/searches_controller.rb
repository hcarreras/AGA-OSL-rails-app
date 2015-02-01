class Stock::SearchesController < ApplicationController
  before_action :login
  skip_before_filter :verify_authenticity_token

  def create
    @sheet = params[:request_data].blank? ? document.data : document.search(params[:request_data])
    respond_to do |format|
      format.json{ render json: @sheet}
    end
  end

  def login
    @session = GoogleDrive.login(ENV["GDRIVE_USERNAME"], ENV["GDRIVE_PASSWORD"])
  end

  def document
    Document.new(@session.spreadsheet_by_key("1UAB7hIZ_iHl1L1i3P6m--rclLCf8wR-8g6jcQ3dRthQ").worksheets[0])
  end
end
