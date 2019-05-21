class OrderMailer < ApplicationMailer
  default from: 'test@fraternitedupiranha.com'

  def welcome_email
    mail(to: 'benoit.cote-jodoin.1@etsmtl.net', subject: 'Welcome to My Awesome Site')
  end
end
