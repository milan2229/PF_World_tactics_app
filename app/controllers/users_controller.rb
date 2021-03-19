class UsersController < ApplicationController
  # before_action :set_user

  def index
    # @users = User.page(params[:page]).reverse_order
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(name: :asc).page(params[:page])
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(8).pluck(:post_id))

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
   if  @user.update(user_params)
    flash[:notice] = "編集が完了しました。"
    redirect_to user_path(@user.id)
   else
    flash[:alert] = "内容を入力してください。"
    render :edit
   end
  end

 def follower
   @user = User.find(params[:user_id])
   @users = @user.follower_user
 end

 def followed
   @user = User.find(params[:user_id])
   @users = @user.following_user
 end

 private

 def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
 end

end


