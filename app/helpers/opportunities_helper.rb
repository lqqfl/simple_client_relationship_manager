module OpportunitiesHelper

  def opp_companies(id)
    links = []
    Opportunity.find_companies(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end

  def opp_contacts(id)
    links = []
    Opportunity.find_contacts(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end

  def opp_activities(id)
    links = []
    Opportunity.find_activities(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end

  def opp_users(id)
    links = []
    Opportunity.find_users(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end      
end
