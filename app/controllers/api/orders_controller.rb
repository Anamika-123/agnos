class Api::OrdersController < Api::BaseController
  def show
    render json: {
      items: current_order.order_items.map(&:as_json)
    }.merge(current_order.as_json)
  end

  def placed
    current_order.completed!
    
    if current_order.completed?
      render json: {
        message: "Your order was successfully placed"
      }
    else
      render json: { error: current_order.errors.full_messsages }, status: 422
    end
  end
end
