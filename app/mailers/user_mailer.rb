class UserMailer < ActionMailer::Base
  def welcome_email(user)
    @user = User.find(user.id)

    mail to: @user.email, subject: 'Welcome'
  end
end
