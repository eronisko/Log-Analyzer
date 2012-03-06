class IgnoreList < ActiveRecord::Base
  validates :name, :pattern_list, presence: true
  validates_uniqueness_of :name

  def filter_log(log)
    patterns = get_patterns_from_string(pattern_list)

    log.log_messages.each do |log_message|
      patterns.each do |pattern|
        if log_message.raw_message.include? pattern then
      	  log_message.ignore!
      	  break
        end
      end
    end
  end

  private

  def get_patterns_from_string(pattern_string)
    pattern_string.each_line.collect { |pattern| pattern.chomp }
  end
end
