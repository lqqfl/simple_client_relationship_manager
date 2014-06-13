class Contact < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :relationships, foreign_key: :contact_id
  has_many :users, through: :relationships
  has_many :companies, through: :relationships
  has_many :opportunities, through: :relationships
  has_many :actvities, through: :relationships
  has_many :contracts, through: :relationships


  def self.find_users(contact_id)
    users=[]
    contact_rl = Relationship.where(contact_id: contact_id)
    contact_rl.each do |item|
      users << User.find_by(id: item.user_id)
    end
    users
  end

  def self.find_companies(contact_id)
    companies = []
    company_rl = Relationship.where(contact_id: contact_id)
    company_rl.each do |item|
      companies << Company.find_by(id: item.company_id)
    end
    companies
  end

end
