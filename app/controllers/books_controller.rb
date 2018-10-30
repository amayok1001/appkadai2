class BooksController < ApplicationController
before_action :correct_user, only: [:edit, :update]

    
    def top
    end

    def about
    end

    def index
        # 投稿全件取得
        @books = Book.all
        # 新規投稿のための空のインスタンス作成
        @new = Book.new
        @user = current_user
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
        @new = Book.new
    end

    def create
        @new = Book.new(book_params)
        @new.user_id = current_user.id
        @user = current_user
        @books = Book.all        
        if @new.save
            flash[:notice] = "Book was successfully created."
            redirect_to book_path(@book)
        else
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
