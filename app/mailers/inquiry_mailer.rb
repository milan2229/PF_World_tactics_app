class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail to: ENV['KEY'], subject: '【World Tactics】お問い合わせ通知'
  end
end
