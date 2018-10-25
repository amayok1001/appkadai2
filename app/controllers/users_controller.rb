class UsersController < ApplicationController
before_action :correct_user, only: [:edit, :update]


    def index
        @users = User.all
        @new = Book.new
        @user = current_user
    end

    # マイページ
    def show
        @new = Book.new
        @book = Book.find(params[:id])
        @user=  User.find(params[:id])
        @books = @user.books
    end

    def create
        @book = Book.new(book_params)
        @book.save
        redirect_to book_path(@user)
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to user_path(@user)

    end


    private
    def user_params
        params.require(:user).permit(:name, :intro, :profile_image)
    end
    def correct_user
        @user = User.find(params[:id])
        if current_user != @user
          redirect_to root_path
        end
    end

end
