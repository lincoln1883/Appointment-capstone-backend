class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    current_user = User.find_by(id: 1)
    @reservations = Reservation.includes(:trade).where(user_id: current_user)
    render json: @reservations, include: :trade, status: :ok
  end

  before_action :authenticate_user!
  def create
    @trade_id = params[:trade_id]
    @trade = Trade.find_by(id: @trade_id)
    @date = params[:date]
    @city = params[:city]
    @message = nil
    @status = nil

    if @trade.nil?
      @message = 'Trade not found'
      @status = :not_found
    else
      @reservation = Reservation.new(user: current_user, trade: @trade, date: @date, city: @city)
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

  before_action :authenticate_user!
  def show
    reservation_id = params[:id]
    reservations = Reservation.includes(:trade).where(id: reservation_id, user_id: current_user.id)

    if reservations.empty?
      render json: { message: 'No reservations found for the user and trades.' }, status: :not_found
    else
      render json: reservations, include: :trade, status: :ok
    end
  end

  before_action :authenticate_user!
  def destroy
    reservation = Reservation.find(params[:id])
    if reservation.destroy
      render json: { message: 'Reservation deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete reservation' }, status: :unprocessable_entity
    end
  end
end
