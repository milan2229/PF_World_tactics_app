class NotificationMailer < ActionMailer::Base
  # default from: "hogehoge@example.com"
  default from: "from@example.com"

  def send_confirm_to_user
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
