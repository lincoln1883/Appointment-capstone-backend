class Api::V1::UsersController < ApplicationController
  def index
    render json: { message: 'Trade reserved successfully' }, status: :created
  end
end
