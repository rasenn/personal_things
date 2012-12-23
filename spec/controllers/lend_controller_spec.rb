require 'spec_helper'

describe LendController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'regist_book'" do
    it "returns http success" do
      get 'regist_book'
      response.should be_success
    end
  end

  describe "GET 'detail_book'" do
    it "returns http success" do
      get 'detail_book'
      response.should be_success
    end
  end

  describe "GET 'things_list'" do
    it "returns http success" do
      get 'things_list'
      response.should be_success
    end
  end

end
