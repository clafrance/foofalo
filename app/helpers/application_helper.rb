module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Foofalo"
    if page_title.empty?
      base_title
    else
      "#{base_title}: #{page_title}"
    end
  end
  
  def beginning_of_day(obj)
    obj.created_at.beginning_of_day
  end
  
  def end_of_day(obj)
    obj.created_at.end_of_day
  end
  
  def full_name(first, last)
    full_name = first + ' ' + last
  end
  
end
