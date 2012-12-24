# -*- coding: utf-8 -*-
class LendController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if params[:param]
      @books = Book.find_book(params[:param]).page(1)
    else
      @books = Book.page(1)
    end
  end

  def regist_book
    if params[:param]
      book_id = Book.regist_book(params[:param])
      HasBook.new(:book_id => book_id, :user_id => current_user.id).save
      @message = "登録しました"
    end
  end

  def detail_book
    if params[:book_id]
      @book = Book.find(params[:book_id])

      # 本がない場合
      redirect_to :action => :index unless @book
    else
      redirect_to :action => :index
    end
  end

  def things_list
    if params[:user_id]
      @books = HasBook.users_things(params[:user_id])
    else
      @books = HasBook.users_things(current_user.id)
    end
  end



end
