class BooksController < ApplicationController

  before_action :authenticate_user! # ログイン必須

  before_action :is_matching_login_user, only: [:edit, :update,:destroy] # 本人のみ編集可能



  def index
    @new_book = Book.new
    @books = Book.all
    @current_user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @current_user = current_user
    @new_book = Book.new
    @books = current_user.books
    @user = @book.user
    @user_image = @user.profile_image

  end


  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @books = Book.all

    if @book.save
      redirect_to book_path(@book), notice: "successfully"
    else
      flash.now[:alert] = "error"
      @new_book = Book.new
      render :index
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "successfully"
    else
      flash.now[:alert] = "error"
      render :edit
    end
  
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end

  private  

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)  
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path 

    end
  end





end
