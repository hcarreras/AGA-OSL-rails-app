require 'spec_helper'

describe StockController, type: :controller do
  it "index" do
    get 'index'
  end

  it "index.js" do
    get 'index', {:format => 'json'}
  end
end
