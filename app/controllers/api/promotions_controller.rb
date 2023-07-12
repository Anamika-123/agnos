class Api::PromotionsController < Api::BaseController
  def create
    promotion = Promotion.new(promotion_params)

    if promotion.save
      render json: promotion.as_json
    else
      render json: { errors: promotion.errors.full_messages }, status: 422
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(
      :type,
      :product_id,
      :discounted_product_id,
      :discount_type,
      :discount,
      :active,
      :system,
    )
  end
end