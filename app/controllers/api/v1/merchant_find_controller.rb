class Api::V1::MerchantFindController < ApplicationController
  def index
    # require'pry';binding.pry
    render json: MerchantSerializer.new(Merchant.where("name ~* :name", { :name => params[:name] }))
    # render json: MerchantSerializer.new(Merchant.where("name ~* ?", params[:name]))
  end

  def show
  end
end