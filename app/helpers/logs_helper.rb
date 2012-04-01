module LogsHelper
  require 'google_chart'
  require 'csv'
  MAX_VALUES_SHOWN = 15


  def ignored_messages_chart
    pie_chart( [{ title: "Active",
                  data:  @log.log_messages.active.count },
                { title: "Ignored",
                  data:  @log.log_messages.ignored.count }]
             )
  end

  def matched_messages_chart
    pie_chart( [{ title: "Unmatched",
                  data:  @log.log_messages.unmatched.count },
                { title: "Matched",
                  data:  @log.log_messages.matched.count }]
             )
  end

  def custom_name_breakdown_chart
    pattern_groups = @log.log_messages.matched.group(:message_pattern_id).count
    data = Array.new
    pattern_groups.each do |patt_id,message_count|
      data << { title: MessagePattern.find(patt_id).name,
                data:  message_count
              }
    end
    pie_chart data
  end

  def category_breakdown_chart
    category_groups = @log.log_messages.matched.joins{message_pattern}.
                                        group{message_patterns.category}.count
    logger.debug category_groups.inspect
    data = Array.new
    category_groups.each do |category,message_count|
      data << { title: category,
                data:  message_count
              }
    end
    pie_chart(data)
  end

  def custom_field_breakdown_chart(field_name)
    custom_fields_groups = 
      @log.log_messages.matched.where("#{field_name} IS NOT NULL").
                                group(field_name.to_sym).count

    if !custom_fields_groups.blank? then
      data = Array.new
      custom_fields_groups.each do |group,message_count|
        data << { title: group,
                  data:  message_count
                } 
      end
      pie_chart(data, field_name)
    end 
  end


  def pie_chart(chart_data, heading=nil)
    chart_data = group_small_as_various(chart_data)
    chart = GoogleChart::PieChart.new("400x200", heading, false) do |pc| 
      chart_data.each do |d|
        pc.data d[:title], d[:data]
      end
    end
    image_tag chart.to_url
  end

  def chart_canvas(&block)
    content = capture(&block)
    content_tag :div, content, class: "span-11 chart_canvas"
  end

  def show_log_messages
    CSV.generate do |csv|
      cols = ["timestamp"]
      cols += 1.upto(Source::CUSTOM_FIELDS_COUNT).map{|n| "field_#{n}"}
      csv << cols.map {|col| col.humanize}
      @log.log_messages.matched.each do |message|
        csv << cols.map{ |col| message[col.to_sym] }
      end
    end
  end

  private

  # Group values that are too small to show as 'Other'
  def group_small_as_various(chart_data)
    others = 0
    while chart_data.length >= MAX_VALUES_SHOWN
    	other = chart_data.min_by{|chart| chart[:data]}
    	chart_data.delete(other)
    	others += other[:data]
    end
    chart_data << {title: "Others", data: others} if others > 0 
    chart_data
  end
end
