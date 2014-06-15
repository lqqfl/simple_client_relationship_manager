class Contact < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :relationships, foreign_key: :contact_id
  has_many :users, through: :relationships
  has_many :companies, through: :relationships
  has_many :opportunities, through: :relationships
  has_many :activities, through: :relationships
  has_many :contracts, through: :relationships


  def self.find_users(contact_id)
    users=[]
    ids = []
    users_rl = Relationship.where(contact_id: contact_id)
    users_rl.each do |item|
      ids << item.user_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| users << User.find_by(id: id) }
    users
  end

  def self.find_companies(contact_id)
    companies = []
    ids = []
    company_rl = Relationship.where(contact_id: contact_id)
    company_rl.each do |item|
      ids << item.company_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| companies << Company.find_by(id: id) }
    companies
  end

end
