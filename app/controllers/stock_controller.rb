require 'google_drive/google_docs'
class StockController < ApplicationController
  before_filter :google_drive_login, :only => [:index]

  def index
    google_session = GoogleDrive.login_with_oauth(session[:google_token])
    @sheet = google_session.spreadsheet_by_key("0AgWDbm7D_t2RdGFfdldFX3Z1aFllRG83bjZTYzU5VkE").worksheets[0]

    respond_to do |format|
      format.html
      format.json{ render json: @sheet.rows[2..-1].map{|row| row_to_hash(@sheet, row)}}
    end
  end

  def show
    google_session = GoogleDrive.login_with_oauth(session[:google_token])
    @sheet = google_session.spreadsheet_by_key("0AgWDbm7D_t2RdGFfdldFX3Z1aFllRG83bjZTYzU5VkE").worksheets[0]

    respond_to do |format|
      format.json{ render json: row_to_hash(@sheet, @sheet.rows[params[:id].to_i])}
    end
  end

  def list_google_docs
    google_session = GoogleDrive.login_with_oauth(session[:google_token])
    @google_docs = []
    for file in google_session.files
      @google_docs << file.title
    end
  end

  def download_google_docs
    file_name = params[:doc_upload]
    file_name_session = GoogleDrive.login_with_oauth(session[:google_token])
    file_path = Rails.root.join('tmp', "doc_#{file_name_session}")
    file = google_session.file_by_title(file_name)
    file.download_to_file(file_path)
    redirect_to list_google_doc_path
  end

  def set_google_drive_token
    google_doc = GoogleDrive::GoogleDocs.new(ENV['google_client_id'], ENV['google_client_secret'],
                                             ENV['google_client_redirect_uri'])
    oauth_client = google_doc.create_google_client
    auth_token = oauth_client.auth_code.get_token(params[:code],
                                                  :redirect_uri => ENV['google_client_redirect_uri'])
    session[:google_token] = auth_token.token if auth_token
    redirect_to stock_index_path
  end

  def google_drive_login
    unless session[:google_token].present?
      google_drive = GoogleDrive::GoogleDocs.new(ENV['google_client_id'], ENV['google_client_secret'],
                                                 ENV['google_client_redirect_uri'])
      auth_url = google_drive.set_google_authorize_url
      redirect_to auth_url
    end
  end

  private

  def row_to_hash(sheet, row)
    row.each_with_index.map do |data, index|
      [sheet.rows[1][index], data]
    end.to_h
  end
end