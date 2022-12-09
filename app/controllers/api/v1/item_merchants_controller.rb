# frozen_string_literal: true

module Api
  module V1
    class ItemMerchantsController < ApplicationController
      def show
        if Item.exists?(params[:id])
          render json: MerchantSerializer.new(Merchant.find(Item.find(params[:id]).merchant_id))
        else
          render json: { errors: 'Not Found' }, status: 404
        end
      end
    end
  end
end
