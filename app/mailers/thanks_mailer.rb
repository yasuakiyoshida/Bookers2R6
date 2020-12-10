class ThanksMailer < ApplicationMailer

  def complete_mail(user)
    @user = user
    mail to: @user.email, subject: "COMPLETE join your address"
  end
end
