class UserMailer < ApplicationMailer
  default from: 'coffee-restaurant-noreply@gmail.com'

  def order_completion_mail
    @customer_email = params[:customer_email]
    @order_id = params[:order_id]

    mail(
      to: @customer_email,
      subject: "ORDER ID: #{ @order_id }"
    )
  end
end
