class Activity < ActiveRecord::Base
  validates :name, :time, presence: true
  
end
