# -*- coding: utf-8 -*-
class Book < ActiveRecord::Base
  has_many :has_books
  has_many :users, :through => :has_books
  
  attr_accessible :amazon_url, :isbn10, :isbn13, :name, :has_someone

  # 検索結果を返す
  def self.find_book(param=nil)
    if param
      return Book.where(["ISBN10 = ? or ISBN13 = ? or amazon_url = ? or name like ? ",param,param,param,"%"+param.to_s+"%"]).where(:has_someone => true)
    else
      return Book.where(:has_someone => true)
    end
  end

  # 商品をISBN10,ISBN13,amazonURLで登録する。
  # ただし、登録できない場合はfalseを返し
  # 商品が見つからない場合、引数がない場合、nilを返す
  def self.regist_book(param)
    if param
      param = param.strip
      books = Book.where(["isbn10 = ? or isbn13 = ? or amazon_url = ?",param,param,param])

      # すでに登録されている本の場合、パスする
      if books.count > 0
        return books[0]

      # まだ登録されていない本の場合
      else
        # amazonで商品を検索する
        product = self.find_amazon_product(param)

        # 商品が見つかった場合、登録する
        if product
          book = Book.new
          book.name = product[0]
          book.isbn10 = product[1]
          book.isbn13 = product[2]
          book.amazon_url = product[3]
          book.amazon_img = product[4]

          book.save
          return book

        # 商品が見つからない場合nilを返す
        else
          return nil
        end
      end
      # 引数がない場合
    else
      return nil
    end
  end

  # TODO: あとで消す
  def self.stub_regist()
    product = ["RailsによるアジャイルWebアプリケーション開発 第4版",
            "4274068668",
            "978-4274068669",
            "http://www.amazon.co.jp/Rails%E3%81%AB%E3%82%88%E3%82%8B%E3%82%A2%E3%82%B8%E3%83%A3%E3%82%A4%E3%83%ABWeb%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E9%96%8B%E7%99%BA-%E7%AC%AC4%E7%89%88-Sam-Ruby/dp/4274068668/ref=sr_1_2?s=books&ie=UTF8&qid=1356265306&sr=1-2",
            "http://ec2.images-amazon.com/images/I/51Gibg-iYTL._BO2,204,203,200_PIsitb-sticker-arrow-click,TopRight,35,-76_AA300_SH20_OU09_.jpg"]
    
    book = Book.new
    book.name = product[0]
    book.isbn10 = product[1]
    book.isbn13 = product[2]
    book.amazon_url = product[3]
    book.amazon_img = product[4]
    book.save
  end



  private
  # amazon商品の検索
  # [商品名,ISBN10,ISBN13,amazonURL,imageURL]を返す
  # すでに登録されている場合、trueを返す
  # FIXME: まだ作ってない
  def self.find_amazon_product(param)
    res = Amazon::Ecs.item_search(param,
                                  {:search_index => 'Books',
                                    :response_group => 'Medium',
                                    :country => 'jp'})
    #item = res.items[0]
    res.items.each do |item|
    return [item.get("ItemAttributes/Title"),
            item.get("ItemAttributes/ISBN"),
            nil, # ISBN13なんてなかった
            item.get("DetailPageURL"),
            item.get("MediumImage/URL")
            ]
    end



#    return ["RailsによるアジャイルWebアプリケーション開発 第4版",
#            "4274068668",
#            "978-4274068669",
#            "http://www.amazon.co.jp/Rails%E3%81%AB%E3%82%88%E3%82%8B%E3%82%A2%E3%82%B8%E3%83%A3%E3%82%A4%E3%83%ABWeb%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E9%96%8B%E7%99%BA-%E7%AC%AC4%E7%89%88-Sam-Ruby/dp/4274068668/ref=sr_1_2?s=books&ie=UTF8&qid=1356265306&sr=1-2",
#            "http://ec2.images-amazon.com/images/I/51Gibg-iYTL._BO2,204,203,200_PIsitb-sticker-arrow-click,TopRight,35,-76_AA300_SH20_OU09_.jpg"]
  end

end
