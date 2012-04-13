module ApplicationHelper
  def show_notice
    if notice
      content_tag :p, notice, class: "success"
    end
  end
end
