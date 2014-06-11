class Opportunity < ActiveRecord::Base
  validates :name, presence: true
end
