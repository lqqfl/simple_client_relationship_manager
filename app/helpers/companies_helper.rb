module CompaniesHelper

  def company_users(id)
    userlinks = []
    Company.find_users(id).each do |user|
      userlinks << user.name if user
    end
    userlinks.join(',')
  end
end
