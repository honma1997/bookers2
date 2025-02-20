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
    @user_image = @user.image

  end


  def edit
    @book = Book.find(params[:id])

  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @book.save
    redirect_to book_path(@book)
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)  
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end

  private  

  def book_params
    params.require(:book).permit(:title, :body, :image)  
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to users_path and return 

    end
  end





end
