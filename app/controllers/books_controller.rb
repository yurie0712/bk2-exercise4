class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all
    @book_new = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  def correct_user                                                              # 正しいユーザーかどうか確認
      @book = Book.find(params[:id])                                            # URLのidの値と同じユーザーを@userに代入
      redirect_to books_path unless @book.user == current_user
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end