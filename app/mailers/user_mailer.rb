class UserMailer < ApplicationMailer
  default from: "gao@blackwright.com"

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Tracebook!"
  end
end
