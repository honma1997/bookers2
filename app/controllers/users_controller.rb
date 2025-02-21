class UsersController < ApplicationController

  before_action :authenticate_user! # ログイン必須

  before_action :is_matching_login_user, only: [:edit, :update] # 本人のみ編集可能

  def index
    @users = User.all
    @current_user = current_user
    @book = Book.new
  end

  def show  
    @user = User.find(params[:id])
    @book = Book.new
    @books = current_user.books
    @user_image = @user.profile_image

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "successfully"
    else
      flash.now[:alert] = "error"
      render :edit
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to users_path and return 

    end
  end


end
