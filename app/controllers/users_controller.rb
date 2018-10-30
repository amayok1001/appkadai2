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
        @user =  User.find(params[:id])
        @book = @user.books
    end

    def create
        @new = Book.new(book_params)
        @users = User.all
        @user = current_user
        if @new.save
            flash[:notice] = "Book was successfully created."
            redirect_to book_path(@book)
        else
            render :index
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user)
        else
            render :edit
        end
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
