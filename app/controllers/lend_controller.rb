# -*- coding: utf-8 -*-
class LendController < ApplicationController
  before_filter :authenticate_user!

  def index
    list_page = params[:page] ? params[:page.to_i] : 1
    list_page = 1 if list_page == 0

    if params[:param]
      @books = Book.find_book(params[:param]).page(list_page)
    else
      @books = Book.find_book().page(list_page)
    end
  end

  def regist_book
    if params[:param]
      book = HasBook.regist_book(params,current_user.id)
      @regist_book_name = book.name
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
      @user_id = params[:user_id]
      @books = HasBook.users_things(params[:user_id])
    else
      @books = HasBook.users_things(current_user.id)
    end
  end

  def del_my_thing
    if params[:book_id]
      HasBook.delete_ones_thing(current_user.id, params[:book_id])
      redirect_to(:action => :things_list)
    else
      redirect_to(:action => :things_list)
    end
  end

end
