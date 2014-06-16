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

  def timeline
    @sources = Opportunity.where("created_at > ?", Time.now-14.days).order("created_at desc")
  end

  def timeline2
    @sources1 = Activity.where("created_at > ?", Time.now-14.days).order("created_at desc")
  end

  def timeline3
    @sources2 = Contract.where("created_at > ?", Time.now-14.days).order("created_at desc")
  end

  def timeline_datas
    timeline
    temp = @sources.collect{|p|
      "{
      'startDate': '#{p.created_at.strftime("%Y,%m,%d")}',
      'headline': '#{p.name}',
      'text': '#{sanitize p.note.gsub(/\r?\n/, "<br/>")}',
      }"
    }.join(",").html_safe
    timeline2
    temp2 = @sources1.collect{|p|
      "{
      'startDate': '#{p.created_at.strftime("%Y,%m,%d")}',
      'headline': '#{p.name}',
      'text': '#{sanitize p.note.gsub(/\r?\n/, "<br/>")}',
      }"
    }.join(",").html_safe
    # timeline3
    # temp << @sources2.collect{|p|
    #   "{
    #   'startDate': '#{p.created_at.strftime("%Y,%m,%d")}',
    #   'headline': '#{p.name}',
    #   'text': '#{sanitize p.note.gsub(/\r?\n/, "<br/>")}',
    #   }"
    # }.join(",").html_safe
    temp
  end
end
