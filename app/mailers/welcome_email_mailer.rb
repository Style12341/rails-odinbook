class WelcomeEmailMailer < ApplicationMailer
  default from: 'no-reply@dr-indo.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to OdinBook')
  end
end
