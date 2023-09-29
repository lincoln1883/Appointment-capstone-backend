class Api::V1::TradesController < ApplicationController
  def index
    # Retrieve a list of all trades from the database
    @trades = Trade.all

    # Return the list of trades as a JSON response
    render json: @trades, status: :ok
  end

  def create
    # Step 1: Retrieve trade parameters from the request
    trade_params = trade_params()

    # Step 2: Create a new trade instance
    @trade = Trade.new(trade_params)

    # Step 3: Associate the trade with the currently authenticated user
    @trade.user = current_user # You'll need to define the current_user method based on your authentication system

    # Step 4: Save the trade record to the database
    if @trade.save
      render json: @trade, status: :created
    else
      render json: @trade.errors, status: :unprocessable_entity
    end
  end

  def show
    # Retrieve the specific trade based on the ID parameter
    @trade = Trade.find(params[:id])

    if @trade
      # Return the trade details as a JSON response
      render json: @trade, status: :ok
    else
      # Handle the case where the trade with the given ID is not found
      render json: { error: 'Trade not found' }, status: :not_found
    end
  end

  def update
    # Retrieve the specific trade based on the ID parameter
    @trade = Trade.find(params[:id])

    if @trade
      # Attempt to update the trade with the provided parameters
      if @trade.update(trade_params)
        render json: @trade, status: :ok
      else
        render json: @trade.errors, status: :unprocessable_entity
      end
    else
      # Handle the case where the trade with the given ID is not found
      render json: { error: 'Trade not found' }, status: :not_found
    end
  end

  def destroy
    # Retrieve the specific trade based on the ID parameter
    @trade = Trade.find(params[:id])

    if @trade
      # Attempt to destroy (delete) the trade
      @trade.destroy
      head :no_content
    else
      # Handle the case where the trade with the given ID is not found
      render json: { error: 'Trade not found' }, status: :not_found
    end
  end

  private

  def trade_params
    params.require(:trade).permit(:name, :description, :image, :location, :price, :duration, :trade_type)
  end
end
