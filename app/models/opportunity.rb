class Opportunity < ActiveRecord::Base
  validates :name, presence: true

  has_many :relationships, foreign_key: :opportunity_id
  has_many :users, through: :relationships
  has_many :companies, through: :relationships
  has_many :actvities, through: :relationships
  has_many :contacts, through: :relationships
  has_many :contracts, through: :relationships
end
