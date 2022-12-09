# frozen_string_literal: true

module Api
  module V1
    class MerchantFindController < ApplicationController
      before_action :check_params

      def index
        render json: MerchantSerializer.new(search_by_name)
      end

      def show
        render json: MerchantSerializer.new(search_by_name.first || Merchant.new)
      end

      private

      def search_by_name
        Merchant.where('name ~* :name', { name: params[:name] }).order(:name)
      end

      def check_params
        return unless params[:name] == '' || !params[:name]

        render json: { errors: 'Not Found' }, status: 400
      end
    end
  end
end
