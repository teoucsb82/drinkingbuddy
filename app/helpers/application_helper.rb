module ApplicationHelper
  
  def format_time(time)
    return time.strftime("%m/%d/%Y")
  end  

  def display_time(time)
    time += 7.hours
    return time.strftime("%A, %b %d - %l:%M %p")
  end
end
