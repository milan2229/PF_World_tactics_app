class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #

  def registration_confirmation(resource)
    # @greeting = ""
    @user = resource
    mail to: @user.email,
         subject: "World Tactics 登録確認メール"
    # @user = user
  end
end
