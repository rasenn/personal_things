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

  def reginst_thing(in_user_id,in_book_id)
    has_book = HasBook.new
    has_book.user_id = in_user_id
    has_book.book_id = in_book_id
    has_book.save
  end
end
