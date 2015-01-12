require 'google_drive/google_docs'
class StockController < ApplicationController
  before_action :login

  def index
    @sheet = document

    respond_to do |format|
      format.html
      format.json{ render json: document.rows[2..-1].map{|row| row_to_hash(document, row)}}
    end
  end

  def show
    rows = document.rows[1..-1]

    respond_to do |format|
      format.json{ render json: row_to_hash(document, rows[params[:id].to_i])}
    end
  end

  def login
    @session = GoogleDrive.login(ENV["GDRIVE_USERNAME"], ENV["GDRIVE_PASSWORD"])
  end

  def document
    @session.spreadsheet_by_key("0AgWDbm7D_t2RdGFfdldFX3Z1aFllRG83bjZTYzU5VkE").worksheets[0]
  end

  private

  def row_to_hash(sheet, row)
    row.each_with_index.map do |data, index|
      [sheet.rows[1][index], data]
    end.to_h
  end
end