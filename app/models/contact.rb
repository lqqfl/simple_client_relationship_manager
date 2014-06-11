class Contact < ActiveRecord::Base
  validates :name, presence: true
  has_many :relationships, foreign_key: :contact_id
  has_many :users, through: :relationships, source: :contact_id
  has_many :companies, through: :relationships, source: :contact_id
  has_many :opportunities, through: :relationships, source: :contact_id
  has_many :actvities, through: :relationships, source: :contact_id
  has_many :contracts, through: :relationships, source: :contact_id
end
