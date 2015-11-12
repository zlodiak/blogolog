class MessageMailer < ApplicationMailer
  default from: 'no-reply@kalinin.ru'
 
  def message_email(message)
    @message = message
    mail(to: 'prozaik81-2@yandex.ru', subject: 'New message from Blogolog')
  end 
end
