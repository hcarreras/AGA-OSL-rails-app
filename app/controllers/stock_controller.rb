class StockController < ApplicationController
  before_action :login
  skip_before_filter :verify_authenticity_token

  def index
    @sheet = document.data

    respond_to do |format|
      format.html
      format.json{ render json: document.to_hash(without_headers: true)}
    end
  end

  def show
    row = document.find_by_reference(params[:id])
    respond_to do |format|
      format.json{ render json: document.row_to_hash(row)}
    end
  end

  def destroy
    if document.delete_row(params[:id])
      head 200, content_type: "text/html"
    else
      head 500, content_type: "text/html"
    end
  end

  def login
    @session = GoogleDrive.login(ENV["GDRIVE_USERNAME"], ENV["GDRIVE_PASSWORD"])
  end

  def document
    Document.new(@session.spreadsheet_by_key("0AgWDbm7D_t2RdGFfdldFX3Z1aFllRG83bjZTYzU5VkE").worksheets[0])
  end
end