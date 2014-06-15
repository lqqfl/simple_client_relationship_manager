module ContractsHelper

  def contract_opps(id)
    links = []
    Contract.find_opps(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end

  def contract_companies(id)
    links = []
    Contract.find_companies(id).each do |item|
      links << item.name if item
    end
    links.join(',')    
  end

  def contract_contacts(id)
    links = []
    Contract.find_contacts(id).each do |item|
      links << item.name if item
    end
    links.join(',')    
  end
end
