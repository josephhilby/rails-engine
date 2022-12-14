# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: MerchantSerializer.new(Merchant.all)
      end

      def show
        if Merchant.exists?(params[:id])
          render json: MerchantSerializer.new(Merchant.find(params[:id]))
        else
          render json: { errors: 'Not Found' }, status: 404
        end
      end
    end
  end
end
