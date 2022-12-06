class Api::V1::ItemMerchantsController < ApplicationController
  def show
    if Item.exists?(params[:id])
      # require'pry';binding.pry
      render json: MerchantSerializer.new(Merchant.where(id: Item.find(params[:id]).merchant_id))
    else
      render json: { errors: 'Not Found' }, status: 404
    end
  end
end