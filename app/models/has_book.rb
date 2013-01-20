# -*- coding: utf-8 -*-
class HasBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :book_id, :uniqueness => { :scope => :user_id }

  attr_accessible :book_id, :rend_flag, :user_id


  def self.users_things(user_id)
    
    return User.find(user_id).books
#    HasBook.where(:user_id => user_id).books
  end

  def self.reginst_thing(in_user_id,in_book_id)
    has_book = HasBook.new
    has_book.user_id = in_user_id
    has_book.book_id = in_book_id
    has_book.save
    Book.update(in_book_id, :has_someone => true )
  end

  def self.delete_ones_thing(in_user_id, in_book_id)
    has_book = HasBook.where(:book_id => in_book_id).where(:user_id => in_user_id)
    has_book.delete_all
    if has_book = HasBook.where(:book_id => in_book_id).count == 0
      Book.update(in_book_id, :has_someone => false )
    end
  end


  def self.regist_book(params,user_id)
    book = Book.regist_book(params[:param])

    if self.where(:book_id => book.id).where(:user_id => user_id).count == 0
      self.new(:book_id => book.id, :user_id => user_id).save
    end
    
    return book
  end

end
