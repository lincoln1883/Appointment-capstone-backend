class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :trade
  validates :user_id, uniqueness: { scope: [:trade_id, :date] }
end
