class GoogleDriveController < ApplicationController
  def index
    require "rubygems"
    require "google/api_client"
    require "google_drive"

    client = OAuth2::Client.new(
        "856718752431-k3j9e5f4064t1qfq591312b9l0nvm8ji.apps.googleusercontent.com", "uBkAntSzq2B5oqGcGi3GyaxK",
        :site => "http://127.0.0.1:3000",
        :token_url => "/o/oauth2/token",
        :authorize_url => "/google_drive")
    auth_url = client.auth_code.authorize_url(
        :redirect_uri => "http://example.com/",
        :scope =>
            "https://docs.google.com/feeds/ " +
                "https://docs.googleusercontent.com/ " +
                "https://spreadsheets.google.com/feeds/")
    auth_token = client.auth_code.get_token(
        authorization_code, :redirect_uri => "http://example.com/")
    session = GoogleDrive.login_with_oauth(auth_token.token)
  end
end