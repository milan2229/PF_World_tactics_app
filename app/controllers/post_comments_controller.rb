class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    @comment_item = comment.post
    if comment.save
      @comment_item.create_notification_comment!(current_user, post_comment_params)
      redirect_to post_path(@post)
    else
      flash[:alert] = "コメントを入力してください。"
      render post_path(@post)
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
