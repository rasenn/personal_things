# -*- coding: utf-8 -*-
require 'spec_helper'

describe Book do
  pending "add some examples to (or delete) #{__FILE__}"

  context "どんな状態でも" do
    it "ISBN10で検索する" do
      Book.send(:find_amazon_product,"4274068668").should_not be_nil
    end
  end

  context "が何も登録されていない場合に" do
    before :each do
      Book.all.each {|b| b.destroy }
    end

    it "ISBN10で登録する" do
      Book.regist_book("4274068668").class.should == Fixnum
    end

    it "ISBN13で登録する" do
      Book.regist_book("978-4274068669").class.should == Fixnum
    end

    it "amazon URLで登録する" do
      Book.regist_book("http://www.amazon.co.jp/Rails%E3%81%AB%E3%82%88%E3%82%8B%E3%82%A2%E3%82%B8%E3%83%A3%E3%82%A4%E3%83%ABWeb%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E9%96%8B%E7%99%BA-%E7%AC%AC4%E7%89%88-Sam-Ruby/dp/4274068668/ref=sr_1_2?s=books&ie=UTF8&qid=1356265306&sr=1-2").class.should == Fixnum
    end
    
    
  end

  context "がすでに何かが登録されている場合には" do
    before :all do
      Book.all.each{|b| b.destroy }
      Book.stub_regist
    end

    it "多重登録できない" do
      Book.regist_book("4274068668").class.should == Fixnum
    end

    after :all do
      Book.all.each {|b| b.destroy }
    end
  end
  
  
end
