class NotificationsController < ApplicationController

  def index
      @notifications = current_user.passive_notifications.page(params[:page]).per(15)
      @notifications.where(checked: false).each do |notification|
          notification.update_attributes(checked: true)
      end
  end

  def destroy_all
      @notifications = current_user.passive_notifications.destroy_all
      redirect_to notifications_path
  end

end
