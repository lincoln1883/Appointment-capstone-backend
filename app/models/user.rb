class User < ApplicationRecord
  validates :name, presence: true

  before_create :set_default_role
  def set_default_role
    self.role ||= 'user'
  end

  def admin?
    role == 'admin'
  end
end
