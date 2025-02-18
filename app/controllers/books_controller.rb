class BooksController < ApplicationController

  before_action :authenticate_user! # ログイン必須


  def index
    @books = Book.all
    @current_user = current_user
  end

  def show
    @book = Book.find(params[:id])

  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(params[:id])
    @book.user = current_user
    @book.save
    redirect_to book_path(@book)
  end

  def update
  end

  def destroy
  end




end
