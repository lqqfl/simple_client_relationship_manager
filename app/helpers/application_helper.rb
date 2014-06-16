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
    # timeline2
    # temp << @sources1.collect{|p|
    #   "{
    #   'startDate': '#{p.created_at.strftime("%Y,%m,%d")}',
    #   'headline': '#{p.name}',
    #   'text': '#{sanitize p.note.gsub(/\r?\n/, "<br/>")}',
    #   }"
    # }.join(",").html_safe
    # timeline3
    # temp << @sources2.collect{|p|
    #   "{
    #   'startDate': '#{p.created_at.strftime("%Y,%m,%d")}',
    #   'headline': '#{p.name}',
    #   'text': '#{sanitize p.note.gsub(/\r?\n/, "<br/>")}',
    #   }"
    # }.join(",").html_safe
    # temp.sort_by("startDate")
    temp
  end

  def charts
    @num = User.find_contacts(current_user.id).count
    @chart = User.sale_situation_chart(current_user.id)
    @chart2 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
      f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
      f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} },
        {:title => {:text => "Population in Millions"}, :opposite => true},
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    @chart3 = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
          series = {
                   :type=> 'pie',
                   :name=> 'Browser share',
                   :data=> [
                      ['Firefox',   45.0],
                      ['IE',       26.8],
                      {
                         :name=> 'Chrome',    
                         :y=> 12.8,
                         :sliced=> true,
                         :selected=> true
                      },
                      ['Safari',    8.5],
                      ['Opera',     6.2],
                      ['Others',   0.7]
                   ]
          }
          f.series(series)
          f.options[:title][:text] = "THA PIE"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
          f.plot_options(:pie=>{
            :allowPointSelect=>true, 
            :cursor=>"pointer" , 
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
    end

    @chart4 = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'John',:data=> [3, 20, 3, 5, 4, 10, 12 ])
      f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )     
      f.title({ :text=>"example test title from controller"})
      f.options[:chart][:defaultSeriesType] = "column"
      f.plot_options({:column=>{:stacking=>"percent"}})
    end
    
    @chart5 = LazyHighCharts::HighChart.new('basic_line') do |f|
      f.chart({ type: 'line',
                marginRight: 130,
                marginBottom: 25 })
      f.title({  text: 'Monthly Average Temperature',
                 x: -20
      })
      f.xAxis({
         categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      })
      f.yAxis({
        title: {
          text: 'Temperature (°C)'
        },
        plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
        }]
      })
      f.tooltip({
        valueSuffix: '°C'
      })
      f.legend({
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -10,
        y: 100,
        borderWidth: 0
      })
      f.subtitle({
        text: 'Source: WorldClimate.com',
        x: -20
      })
      f.series({
        name: 'Tokyo',
        ldata: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
      })
      f.series(
        name: 'New York',
        data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
      )
      f.series({
        name: 'Berlin',
        data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
      })
      f.series({
          name: 'London',
          data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
      })
    end
  end
end
