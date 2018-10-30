class UsersController < ApplicationController
before_action :correct_user, only: [:edit, :update]
before_action :authenticate_user!


    def index
        @users = User.all
        @book = Book.new
        @user = current_user
    end

    # マイページ
    def show
        @book = Book.new
        @user =  User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "User was successfully edit."
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
