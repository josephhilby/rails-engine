class Api::V1::ItemFindController < ApplicationController
  before_action :check_params

  def index
    if params[:min_price] || params[:max_price]
      render json: ItemSerializer.new(search_by_price)
    elsif params[:name]
      render json: ItemSerializer.new(search_by_name)
    end
  end

  def show
    if params[:min_price] || params[:max_price]
      render json: ItemSerializer.new(search_by_price.first || Item.new)
    elsif params[:name]
      render json: ItemSerializer.new(search_by_name.first || Item.new)
    end
  end

  private

  def search_by_name
    Item.where("name ~* :name", { :name => params[:name] }).order(:name)
  end

  def search_by_price
    if params[:min_price] && params[:max_price]
      Item.where("unit_price >= :min_price AND unit_price <= :max_price", { :min_price => params[:min_price], :max_price => params[:max_price] }).order(:name)
    elsif params[:min_price]
      Item.where("unit_price >= :min_price", { :min_price => params[:min_price] }).order(:name)
    elsif params[:max_price]
      Item.where("unit_price <= :max_price", { :max_price => params[:max_price] }).order(:name)
    end
  end

  def number?(param)
    (!!Float(param) rescue false) && !param.to_i.negative?
  end

  def check_params
    if params_empty? || params_name_and_price? || params_missing? || params_neg_num? || params_min_more_than_max?
      render json: { errors: 'Non-valid params' }, status: 400
    end
  end

  def params_empty?
    (params[:min_price] == '' || params[:max_price] == '' || params[:name] == '')
  end

  def params_name_and_price?
    (!params[:name] && (!params[:min_price] && !params[:max_price]))
  end

  def params_missing?
    (!!params[:name] && (!!params[:min_price] || !!params[:max_price]))
  end

  def params_neg_num?
    (!number?(params[:min_price]) && !number?(params[:max_price]) && (params[:min_price] != nil || params[:max_price] != nil))
  end

  def params_min_more_than_max?
    ((!!params[:min_price] && !!params[:max_price]) && (params[:min_price].to_f > params[:max_price].to_f))
  end
end
