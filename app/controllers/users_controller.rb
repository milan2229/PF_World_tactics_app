class UsersController < ApplicationController
  # before_action :set_user

  def index
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(created_at: "DESC").page(params[:page]).per(10)
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(8).pluck(:post_id))
    # @all_ranks = Post.find(Favorite.group(:post_id).order(created_at: "DESC").limit(8).pluck(:post_id))
    # ↑RSpecで警告出るので一時的にこうしているだけ
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.all
    @favorite_posts = @user.favorite_posts
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
   @users_page = User.page(params[:page]).per(10)
 end

 def followed
   @user = User.find(params[:user_id])
   @users = @user.following_user
   @users_page = User.page(params[:page]).per(10)
 end

 def favorites
   @user = User.find(params[:user_id])
   @favorite_posts = @user.favorite_posts
 end

 private

 def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
 end

end


