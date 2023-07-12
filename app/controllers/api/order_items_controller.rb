class Api::OrderItemsController < Api::BaseController
  def create
    item = order_service.add_item(params[:product_id])

    if order_service.errors.blank?
      render json: item.as_json
    else
      render json: { errors: order_service.errors }
    end
  end

  def update
    item = order_service.update_item(params[:id], params[:quantity])

    if order_service.errors.blank?
      render json: item.as_json
    else
      render json: { errors: order_service.errors }
    end
  end

  def destroy
    item = order_service.delete_item(params[:id])

    if item.destroyed?
      head 200
    else
      render json: { errors: order_service.errors }
    end
  end

  private

  def order_service
    @order_service ||= OrderService.new(current_order)
  end
end