class Activity < ActiveRecord::Base
  validates :name, :time, presence: true
  has_many :relationships, foreign_key: :activity_id
  has_many :opportunities, through: :relationships, source: :activity_id
end
