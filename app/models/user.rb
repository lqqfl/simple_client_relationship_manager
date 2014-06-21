class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, uniqueness: true
  has_many :relationships, foreign_key: :user_id
  has_many :opportunities, through: :relationships
  has_many :companies, through: :relationships
  has_many :actvities, through: :relationships
  has_many :contacts, through: :relationships
  has_many :contracts, through: :relationships

  mount_uploader :avatar, AvatarUploader

  def self.find_contacts(id)
    ids = []
    targets = []
    aaa = Relationship.where("user_id= ?",id)
    aaa.each do |e|
      ids << e.contact_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |e| targets << Contact.find(e) }
    # targets = targets.order(created_at: :desc) if targets.present?
    targets
  end

  def self.find_activity(id)
    ids = []
    targets = []
    aaa = Relationship.where("user_id= ?",id)
    aaa.each do |e|
      ids << e.activity_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |e| targets << Activity.find(e) }
    # targets = targets.order(created_at: :desc) if targets.present?
    targets
  end

  def self.find_opportunity(id)
    ids = []
    targets = []
    aaa = Relationship.where("user_id= ?",id)
    aaa.each do |e|
      ids << e.opportunity_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |e| targets << Opportunity.find(e) }
    # targets = targets.order(created_at: :desc) if targets.present?
    targets
  end

  def self.find_contracts(id)
    ids = []
    targets = []
    aaa = Relationship.where("user_id= ?",id)
    aaa.each do |e|
      ids << e.contract_id
    end
    ids.delete(0)
    ids.uniq!
    ids.each{ |e| targets << Contract.find(e) }
    # targets = targets.order(created_at: :desc) if targets.present?
    targets
  end

  def self.sale_situation_chart(id)
    contacts = User.find_contacts(id).count
    contracts = User.find_contracts(id).count
    opportunities = User.find_opportunity(id).count
    activities = User.find_activity(id).count
    datas = [contacts, opportunities, activities, contracts]

    chart = LazyHighCharts::HighChart.new('sales') do |f|
      f.chart({:defaultSeriesType=>"column"})
      f.title(:text => "Personal Sales Situation")
      f.exporting({enabled: true, enableImages: true, filename: "#{Time.now.strftime "%Y-%m-%d"}-销售人员情况", sourceWidth: 1024, sourceHeight: 400})
      f.credits( text: "by旺田云", href: "http://netfarmer.com.cn")
      f.tooltip({
        valueSuffix: '个',
        shared: true
      })
      f.legend({
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -10,
        y: 100,
        borderWidth: 0
      })
      f.colors(['#F0596B', '#4DB6C5', '#FB6A3F', '#1EBBA6', '#958378', '#05B2D2'])
      f.xAxis(:categories => ["Datas"])
      f.series(:name => "Contact", :data => [contacts])
      f.series(:name => "Opportunity", :data => [opportunities])
      f.series(:name => "Activity", :data => [activities])
      f.series(:name => "contracts", :data => [contracts])
      f.yAxis [
        {:title => {:text => "Counts", :margin => 70} },
      ]
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    end
  end
end
