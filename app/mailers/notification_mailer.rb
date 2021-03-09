class NotificationMailer < ActionMailer::Base
  # default from: "hogehoge@example.com"
  default from: "from@example.com"

  # def send_confirm_to_user(user)
  #   @user = user
  #   mail(subject: "会員登録が完了しました。",to: @user.email)do |format|
  #       format.text
  #       end
  # end
  # def send_confirm_to_user(user)
  #   @user = user
  #   mail(:subject => "登録ありがとう！！！！", to: user.email)
  # end

#   def send_confirm_to_user(user)
#     @user = user
# 	mail(to: @user.email, subject: 'Welcome to Our Application!')
#   end
def send_confirm_to_user
    @greeting = "Hi"

    mail to: "to@example.org"
end
end
