class UserMailer < ApplicationMailer
  default from: ENV['GMAIL_USER_EMAIL']

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Sorta!")
  end
end
