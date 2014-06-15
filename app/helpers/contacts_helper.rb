module ContactsHelper

  def search_users(id)
    users = []
    Contact.find_users(id).each { |user| users << user.name if user }
    users.join(',')
  end

  def search_companies(id)
    companies = []
    Contact.find_companies(id).each do |company|
      companies << company.name if company
    end
    companies.join(',')
  end
end
