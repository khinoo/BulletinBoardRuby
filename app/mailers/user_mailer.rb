class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    @greeting = "Hi"
    
    mail :to => user.email, :subject => "Password Reset"
  end
end