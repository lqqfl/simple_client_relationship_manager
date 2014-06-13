class Relationship < ActiveRecord::Base
  belongs_to :company
  belongs_to :contact
  belongs_to :user
  belongs_to :opportunity
  belongs_to :activity
  belongs_to :cotract

  def self.search(str)
    Relationship.find_by(str)
  end
end
