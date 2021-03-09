class UsersController < ApplicationController
  # before_action :set_user

  def index
    # @users = User.page(params[:page]).reverse_order
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(name: :asc).page(params[:page])
    # UserMailer.registration_confirmation.deliver
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.all
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

 def follower
   @user = User.find(params[:user_id])
   @users = @user.followed
 end

 def followed
   @user = User.find(params[:user_id])
   @users = @user.follower
 end

 private

 def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
 end

end


