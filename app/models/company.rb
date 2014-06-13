class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :relationships, foreign_key: :company_id
  has_many :contacts, through: :relationships
  has_many :activities, through: :relationships
  has_many :opportunities, through: :relationships
  has_many :contracts, through: :relationships
  has_many :users, through: :relationships
end
