module ContactsHelper

  def search_users(id)
    Contact.find_users(id).map{ |user| user.name if user }.join(',')
  end

  def search_companies(id)
    Contact.find_companies(id).map{ |company| company.name if company }.join(',')
  end
end
