class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    reneder json: Item.where(merchant_id: params[:id])
  end
end