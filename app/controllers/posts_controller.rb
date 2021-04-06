class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    # @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @search = Post.ransack(params[:q])
    # @search = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @posts = @search.result(distinct: true).order(created_at: "DESC").includes(:user).page(params[:page]).per(10)
    @posts = @posts.joins(:tag_relationships).where(tag_relationships: {tag_id: params[:tag_id]}) if params[:tag_id].present?
    @all_ranks = Post.find(Favorite.group(:post_id).
    order(Arel.sql('count(post_id) desc')).limit(8).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:tag_ids].split('、')
    @tags = tag_list
    @post.user_id = current_user.id
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "投稿が完了しました。"
      redirect_to posts_path
    else
      flash[:alert] = "内容を入力してください。"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update_attributes(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = '投稿を編集しました‼'
      redirect_to @post
    else
     flash[:alert] = "内容が正しくありません。"
     render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
