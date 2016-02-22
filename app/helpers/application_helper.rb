module ApplicationHelper

  def full_page_title(page_title = '')
    base_title = "Teach and learn anything"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
