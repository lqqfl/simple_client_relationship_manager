class Relationships < ActiveRecord::Base
  belongs_to :company
  belongs_to :contact
  belongs_to :user
  belongs_to :opportunity
  belongs_to :activity
  belongs_to :cotract
end
