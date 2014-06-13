module ApplicationHelper
  
  def user_array
    User.all.map { |item| [item.name, item.id] }
  end
  
  def company_array
    Company.all.map { |company| [company.name, company.id] }
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
