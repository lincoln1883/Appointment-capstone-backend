class Api::V1::ReservationsController < ApplicationController
  def index
    puts "................................"
    puts 'Hey, you are in the reservation controller.'
    
    user_id = 1
    @reservations = Reservation.includes(:trade).where(user_id: user_id)
    if @reservations.any?
      trade_names = @reservations.map { |reservation| reservation.trade.name }
      puts 'Trade names reserved by the user:', trade_names
    else
      puts 'No reservations found for the user.'
    end

    puts "................................"
   
    render json: @reservations, include: :trade, status: :ok
  end

  def create
    puts 'Hey, you are in the reservation controller.'
    current_user = User.find_by(id: 1)
    @tradeId = params[:trade_id]
    puts "................................"
    puts 'The trade is', @tradeId
    puts 'The date is', params[:date]
    puts 'The user is', current_user.name
    puts "................................"

    @trade = Trade.find_by(id: @tradeId)
    @date = params[:date]
    
    @message = nil
    @status = nil

    if @trade.nil?
      @message = 'Trade not found'
      @status = :not_found
    else
      @reservation = Reservation.new(user: current_user, trade: @trade, date: @date)

      if @reservation.save 
        @message = 'Trade reserved successfully'
        @status = :created
      else 
        @errors = @reservation.errors.full_messages
        @error = 'Reservation failed'
        @status = :unprocessable_entity
      end
    end

    response_hash = { message: @message }
    response_hash[:errors] = @errors if @errors
    response_hash[:error] = @error if @error

    render json: response_hash, status: @status
  end
end
