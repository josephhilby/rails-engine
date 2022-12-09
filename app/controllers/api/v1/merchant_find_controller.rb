# frozen_string_literal: true

module Api
  module V1
    class MerchantFindController < ApplicationController
      before_action :check_params

      def index
        render json: MerchantSerializer.new(Merchant.where('name ~* :name', { name: params[:name] }).order(:name))
      end

      def show
        merchant = Merchant.where('name ~* :name', { name: params[:name] }).order(:name).first || Merchant.new
        render json: MerchantSerializer.new(merchant)
      end

      private

      def check_params
        return unless params[:name] == '' || !params[:name]

        render json: { errors: 'Not Found' }, status: 400
      end
    end
  end
end
