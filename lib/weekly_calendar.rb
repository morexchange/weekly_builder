# WeeklyCalendar by Dan McGrady 2011 http://dmix.ca
module WeeklyCalendar
  def weekly_calendar(objects, *args)
    #view helper to build the weekly calendar
    options = args.last.is_a?(Hash) ? args.pop : {}
    date = options[:date] || Time.now
    start_date = Date.new(date.year, date.month, date.day)
    end_date = Date.new(date.year, date.month, date.day) + 6
    
    concat(tag("div", :class => "week"))

      yield WeeklyCalendar::Builder.new(objects || [], self, options, start_date, end_date)

    concat("</div>".html_safe)

    if options[:include_24_hours] == true
      concat("<b><a href='?business_hours=true&start_date=#{start_date}'>Business Hours</a> | <a href='?business_hours=false&start_date=#{start_date}'>24-Hours</a></b>".html_safe)
    end
    ""
  end
  
  def weekly_links(options)
    #view helper to insert the next and previous week links
    date = options[:date] || Time.now
    start_date = Date.new(date.year, date.month, date.day) 
    end_date = Date.new(date.year, date.month, date.day) + 7
    concat("<a href='?start_date=#{start_date - 7}?user_id='>&laquo; Previous Week</a> ".html_safe)
    concat("#{start_date.strftime("%B %d -")} #{end_date.strftime("%B %d")} #{start_date.year}".html_safe)
    concat(" <a href='?start_date=#{start_date + 7}?user_id='>Next Week &raquo;</a>".html_safe)
  end
end