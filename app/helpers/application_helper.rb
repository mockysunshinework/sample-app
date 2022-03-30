module ApplicationHelper

  def text_url_to_link(text)
    require 'uri'
      URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = "<a href=#{url} target=\'_blank\'>#{url}</a>"
      text.gsub!(url, sub_text)
      end
    return text
  end

  def full_title(page_name = "")
    base_title = "Task App"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
end