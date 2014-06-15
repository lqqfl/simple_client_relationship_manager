class Opportunity < ActiveRecord::Base
  validates :name, presence: true

  has_many :relationships, foreign_key: :opportunity_id
  has_many :users, through: :relationships
  has_many :companies, through: :relationships
  has_many :activities, through: :relationships
  has_many :contacts, through: :relationships
  has_many :contracts, through: :relationships

  def self.find_companies(id)
    targets=[]
    ids = []
    temp_rl = Relationship.where(opportunity_id: id)
    temp_rl.each do |item|
      ids << item.company_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| targets << Company.find_by(id: id) }
    targets      
  end

  def self.find_contacts(id)
    targets=[]
    ids = []
    temp_rl = Relationship.where(opportunity_id: id)
    temp_rl.each do |item|
      ids << item.contact_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| targets << Contact.find_by(id: id) }
    targets      
  end

  def self.find_users(id)
    targets=[]
    ids = []
    temp_rl = Relationship.where(opportunity_id: id)
    temp_rl.each do |item|
      ids << item.user_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| targets << User.find_by(id: id) }
    targets    
  end

  def self.find_activities(id)
    targets=[]
    ids = []
    temp_rl = Relationship.where(opportunity_id: id)
    temp_rl.each do |item|
      ids << item.activity_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| targets << Activity.find_by(id: id) }
    targets    
  end

end
