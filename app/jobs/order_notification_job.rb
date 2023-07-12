class OrderNotificationJob <  ApplicationJob
  queue_as :default

  def perform(order)
    UserMailer.with(
      order_id: order.id,
      customer_email: order.user.email
    ).order_completion_mail.deliver_now
  end
end
