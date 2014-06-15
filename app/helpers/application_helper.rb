module ApplicationHelper
  
  def user_array
    User.all.map { |item| [item.name, item.id] }
  end
  
  def company_array
    Company.all.map { |company| [company.name, company.id] }
  end

  def contact_array
    Contact.all.map { |e| [e.name, e.id] }  
  end

  def opportunity_array
    Opportunity.all.map { |e| [e.name, e.id] }
  end

  def activity_array
    Activity.all.map { |e| [e.name, e.id] }
  end

  def active_navbar(controller)
    if request.path =~ /^\/(\w+)\/*/ && $1 == controller
      "active"
    else
      ""
    end
  end

  def active(controller,target)
    controller == target  ? "active" : ""
  end
end
