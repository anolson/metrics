module RidesHelper
  def format_datetime(datetime)
    "#{format_date(datetime)} at #{format_time(datetime)}"
  end
  
  def format_date(date)
    date.strftime('%m/%d/%Y')
  end
  
  def format_time(time)
    time.strftime('%I:%M %p')
  end
end
