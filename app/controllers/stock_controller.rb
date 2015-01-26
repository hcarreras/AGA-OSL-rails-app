class StockController < ApplicationController
  before_action :login
  skip_before_filter :verify_authenticity_token

  def index
    @sheet = document.data

    respond_to do |format|
      format.html
      format.json{ render json: document.to_hash}
    end
  end

  def create
    if document.add_computer(params[:data])
      head 200, content_type: "text/html"
    else
      head 500, content_type: "text/html"
    end
  end

  def show
    computer = document.find_by_reference(params[:id])
    respond_to do |format|
      if computer
        format.json{ render json: computer.to_hash}
      else
        format.json{ render json: {error: "not-found"}, :status => 404}
      end
    end
  end

  def destroy
    if document.delete_row(params[:id])
      head 200, content_type: "text/html"
    else
      head 500, content_type: "text/html"
    end
  end

  def update
    if document.update_computer(params[:id], params[:data])
      head 200, content_type: "text/html"
    else
      head 500, content_type: "text/html"
    end
  end

  def login
    @session = GoogleDrive.login(ENV["GDRIVE_USERNAME"], ENV["GDRIVE_PASSWORD"])
  end

  def document
    Document.new(@session.spreadsheet_by_key("1UAB7hIZ_iHl1L1i3P6m--rclLCf8wR-8g6jcQ3dRthQ").worksheets[0])
  end
end