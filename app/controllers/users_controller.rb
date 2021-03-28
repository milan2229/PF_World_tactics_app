class UsersController < ApplicationController

  def index
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(created_at: "DESC").page(params[:page]).per(10)
    @all_ranks = Post.find(Favorite.group(:post_id).
    order(Arel.sql('count(post_id) desc')).limit(8).pluck(:post_id))
  end

  def show
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "内容を入力してください。"
      render :edit
    end
  end

  def follower
    @user = User.find(params[:user_id])
    @users = @user.follower_user.page(params[:page]).per(5)
  end

  def followed
    @user = User.find(params[:user_id])
    @users = @user.following_user.page(params[:page]).per(5)
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
