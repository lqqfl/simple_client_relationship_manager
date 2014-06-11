class Contract < ActiveRecord::Base
  validates :name, :time, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
