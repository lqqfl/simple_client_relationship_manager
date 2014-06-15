module ActivitiesHelper

  def activity_companies(id)
    links = []
    Activity.find_companies(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end

  def activity_contacts(id)
    links = []
    Activity.find_contacts(id).each do |item|
      links << item.name if item
    end
    links.join(',')
  end

  def activity_users(id)
    userlinks = []
    Activity.find_users(id).each do |user|
      userlinks << user.name if user
    end
    userlinks.join(',')
  end

end
