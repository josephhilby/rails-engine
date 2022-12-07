class Api::V1::ItemMerchantsController < ApplicationController
  def show
    if Item.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(Item.find(params[:id]).merchant_id))
    else
      render json: { errors: 'Not Found' }, status: 404
    end
  end
end