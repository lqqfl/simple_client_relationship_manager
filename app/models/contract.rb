class Contract < ActiveRecord::Base
  validates :name, :time, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  has_many :relationships, foreign_key: :contract_id
  has_many :users, through: :relationships, source: :contract_id
  has_many :companies, through: :relationships, source: :contract_id
  has_many :opportunities, through: :relationships, source: :contract_id
  has_many :actvities, through: :relationships, source: :contract_id
  has_many :contacts, through: :relationships, source: :contract_id
end
