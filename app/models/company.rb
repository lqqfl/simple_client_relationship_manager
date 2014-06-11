class Company < ActiveRecord::Base
  validates :name, presence: true
  has_many :relationships, foreign_key: :company_id
  has_many :contacts, through: :relationships, source: :company_id
  has_many :activities, through: :relationships, source: :company_id
  has_many :opportunities, through: :relationships, source: :company_id
  has_many :contracts, through: :relationships, source: :company_id
  has_many :users, through: :relationships, source: :company_id
end
