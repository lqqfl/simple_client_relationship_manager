class Contract < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, :start_time, :end_time,:exp_amount, presence: true
  validates :exp_amount, :real_amount, numericality: { greater_than_or_equal_to: 0 }

  has_many :relationships, foreign_key: :contract_id
  has_many :users, through: :relationships
  has_many :companies, through: :relationships
  has_many :opportunities, through: :relationships
  has_many :activities, through: :relationships
  has_many :contacts, through: :relationships


  def self.find_opps(id)
    targets=[]
    ids = []
    temp_rl = Relationship.where(contract_id: id)
    temp_rl.each do |item|
      ids << item.opportunity_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| targets << Opportunity.find_by(id: id) }
    targets  
  end

  def self.find_companies(id)
    targets=[]
    ids = []
    temp_rl = Relationship.where(contract_id: id)
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
    temp_rl = Relationship.where(contract_id: id)
    temp_rl.each do |item|
      ids << item.contact_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |id| targets << Contact.find_by(id: id) }
    targets      
  end
end
