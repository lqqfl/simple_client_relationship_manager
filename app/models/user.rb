class User < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :relationships, foreign_key: :user_id
  has_many :opportunities, through: :relationships
  has_many :companies, through: :relationships
  has_many :actvities, through: :relationships
  has_many :contacts, through: :relationships
  has_many :contracts, through: :relationships
end
