# frozen_string_literal: true

module Api
  module V1
    class MerchantItemsController < ApplicationController
      def index
        if Merchant.exists?(params[:merchant_id])
          render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
        else
          render json: { errors: 'Not Found' }, status: 404
        end
      end
    end
  end
end
