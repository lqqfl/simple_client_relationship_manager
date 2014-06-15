class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :relationships, foreign_key: :company_id
  has_many :contacts, through: :relationships
  has_many :activities, through: :relationships
  has_many :opportunities, through: :relationships
  has_many :contracts, through: :relationships
  has_many :users, through: :relationships

  def self.find_users(company_id)
    users=[]
    ids = []
    company_rl = Relationship.where(company_id: company_id)
    company_rl.each do |item|
      ids << item.user_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| users << User.find_by(id: id) }
    users
  end

end
