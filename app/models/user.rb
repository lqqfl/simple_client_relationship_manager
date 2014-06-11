class User < ActiveRecord::Base
  has_many :relationships, foreign_key: :opportunity_id
  has_many :opportunities, through: :relationships, source: :opportunity_id
  has_many :companies, through: :relationships, source: :opportunity_id
  has_many :actvities, through: :relationships, source: :opportunity_id
  has_many :contacts, through: :relationships, source: :opportunity_id
  has_many :contracts, through: :relationships, source: :opportunity_id
end
