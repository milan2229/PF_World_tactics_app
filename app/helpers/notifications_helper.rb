module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @your_post = link_to 'あなたの投稿', users_path(notification), style: "font-weight: bold;"
    @visiter_comment = notification.post_comment_id

    case notification.action
    when "follow"
      tag.a(notification.visiter.name, href: users_path(@visiter),
                                       style: "font-weight: bold;") + "があなたをフォローしました"
    when "favorite"
      tag.a(notification.visiter.name, href: user_path(@visiter),
                                       style: "font-weight: bold;") + "が" +
                                       tag.a('あなたの投稿', href: post_path(notification.post_id),
                                                       style: "font-weight: bold;") + "にいいねしました"
    when "comment" then
      @comment = PostComment.find_by(id: @visiter_comment)&.comment
      tag.a(@visiter.name, href: user_path(@visiter),
                           style: "font-weight: bold;") + "が" +
                           tag.a('あなたの投稿', href: post_path(notification.post_id),
                                           style: "font-weight: bold;") + "コメントしました"
    end
  end

  def unchecked_notifications
    @notification = current_user.passive_notifications.where(checked: false)
  end
end
