class Api::ProductsController < Api::BaseController

  def index
    render json: Product.all.map(&:as_json)
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product.as_json
    else
      render json: { error: product.errors.full_messsages }, status: 422 
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :tax_percentage)
  end
end
