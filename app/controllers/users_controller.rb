class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      @userall = User.all
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @users = @user.books

  end

  def index
    @userall = User.all
    @user = User.find(current_user.id)
    @users = @user.books
    @book_new = @users.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
