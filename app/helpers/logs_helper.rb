module LogsHelper
    require 'google_chart'
  def ignored_messages_chart(log)
    chart = GoogleChart::PieChart.new('320x200', "Disabled",false) do |pc| 
      pc.data "Active", (log.log_messages.count - 
                         log.log_messages.ignored.count)
      pc.data "Ignored", log.log_messages.ignored.count
      pc.show_legend = false
    end
    image_tag chart.to_url
  end
end
