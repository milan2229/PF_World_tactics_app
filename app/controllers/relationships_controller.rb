class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    current_user.follow(params[:id])
    redirect_to request.referer
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end

  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
  end

end
