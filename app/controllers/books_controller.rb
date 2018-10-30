class BooksController < ApplicationController
before_action :correct_user, only: [:edit, :update]
before_action :authenticate_user!, except: [:top,:about]

    def top
    end

    def about
    end

    def index
        # 投稿全件取得
        @books = Book.all
        # 新規投稿のための空のインスタンス作成
        @book = Book.new
        @user = current_user
    end

    def show
        @bookf = Book.find(params[:id])
        @user = @bookf.user
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        @user = current_user
        if @book.save
            flash[:notice] = "Book was successfully created."
            redirect_to book_path(@book)
        else
            @books = Book.all
            render :index
        end
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
        redirect_to book_path(@book)

    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end


    protected
    def book_params
        params.require(:book).permit(:title, :body)
    end

    def correct_user
        @book = Book.find(params[:id])
        @user = @book.user
        if current_user != @user
          redirect_to root_path
        end
     end

end
