require 'spec_helper'

describe StockController, type: :controller do
  it "index.js" do
    get 'index', {format: 'json'}
    expect(response.status).to eq(200)
  end

  it "show.js" do
    get 'show', {id: 1, format: 'json'}
    expect(response.status).to eq(200)
  end
end
