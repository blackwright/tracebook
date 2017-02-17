module ApplicationHelper

  def out(value)
    value.blank? ? "--" : value
  end

  def date_to_string(date)
    "#{date.strftime('%B %-d, %Y')}" if date
  end

  def nav_link_class(path)
    "active" if current_page?(path)
  end
end
