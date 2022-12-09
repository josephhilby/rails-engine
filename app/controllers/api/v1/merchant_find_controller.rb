class Api::V1::MerchantFindController < ApplicationController
  before_action :check_params

  def index
    render json: MerchantSerializer.new(Merchant.where("name ~* :name", { :name => params[:name] }).order(:name))
  end

  def show
    merchant = Merchant.where("name ~* :name", { :name => params[:name] }).order(:name).first || Merchant.new
    render json: MerchantSerializer.new(merchant)
  end

  private

  def check_params
    if params[:name] == '' || !params[:name]
      render json: { errors: 'Not Found' }, status: 400
    end
  end
end