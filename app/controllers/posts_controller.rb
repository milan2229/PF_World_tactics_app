class PostsController < ApplicationController
# before_action :authenticate_user!,except: [:index]
  def new
    @post = Post.new
  end

  def index
    # @posts = Post.page(params[:page]).reverse_order
    @search = Post.ransack(params[:q])
    @posts = @search.result(distinct: true).order(created_at: "DESC").includes(:user).page(params[:page]).per(10)
    # @search_produc= @search.result(distinct: true).order(created_at: "DESC").includes(:user).page(params[:page]).per(5) # productsの検索結果一覧
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(8).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    # @user = User.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    flash[:notice] = "投稿が完了しました。"
    redirect_to posts_path
    else
    flash[:alert] = "内容を入力してください。"
    render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:id])
    # binding.pry
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
