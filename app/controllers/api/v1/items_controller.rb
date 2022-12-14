# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        if Item.exists?(params[:id])
          render json: ItemSerializer.new(Item.find(params[:id]))
        else
          render json: { errors: 'Not Found' }, status: 404
        end
      end

      def create
        render json: ItemSerializer.new(Item.create(item_params)), status: 201
      end

      def update
        if Item.exists?(params[:id]) && (params[:item][:merchant_id].nil? || Merchant.exists?(params[:item][:merchant_id]))
          render json: ItemSerializer.new(Item.update(params[:id], item_params))
        else
          render json: { errors: 'Not Found' }, status: 404
        end
      end

      def destroy
        render json: Item.delete(params[:id])
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
