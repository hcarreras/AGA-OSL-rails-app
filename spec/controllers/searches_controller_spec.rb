require 'spec_helper'

describe Stock::SearchesController , type: :controller do
  describe "search" do
    it "doesn't return the outdated data" do
      tomorrow = DateTime.tomorrow.strftime('%d/%m/%Y')
      post 'create', {request_data: "[{referencia: 1, ultima_modificacion: '#{tomorrow}'}, {referencia: 226, ultima_modificacion: '15/01/2015'}]", format: 'json'}
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.any?{|computer| computer[:referencia] == 1}).to be false
    end
  end
end
