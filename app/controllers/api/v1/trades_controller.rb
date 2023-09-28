class Api::V1::TradesController < ApplicationController
  def index
    @trades = Trade.all
    render json: @trades
  end

  def create
    @trade = Trade.create(trade_params)
    render json: @trade
  end

  def show
    @trade = Trade.find(params[:id])
    render json: @trade
  end

  def update
    @trade = Trade.find(params[:id])
    @trade.update(trade_params)
    render json: @trade
  end

  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy
    render json: @trade
  end

  private

  def trade_params
    params.permit(:user_id, :name, :description, :image, :location, :price, :duration, :type)
  end  

end
