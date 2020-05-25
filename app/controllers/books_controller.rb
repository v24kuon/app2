class BooksController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @books = Book.all
    @book = Book.new
    @users = current_user
  end


  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end


  def new
    @book = Book.new
  end


  def edit
    @book = Book.find(params[:id])
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
      else
        @books = Book.all
        @users = current_user
        format.html { render :index }
      end
    end
  end



  def update
      if @book.update(book_params)
        ( redirect_to @book, notice: 'Book was successfully updated.' )
      else
        ( render :edit )
    end
  end


  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
      ( redirect_to books_url, notice: 'Book was successfully destroyed.' )
  end


  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :body)
    end

  def ensure_correct_user
    @book = Book.find(params[:id])
     if @book.user != current_user
      flash[:notice] = "権限がありません"
      redirect_to(books_path)
    end
  end
end