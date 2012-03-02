class EliminationList < ActiveRecord::Base
  validates :name, :pattern_list, presence: true
  validates_uniqueness_of :name

  def filter_log_message(log_message)
    pattern_list.split("\n").each do |pattern|
      logger.debug "matching against #{pattern}"
      logger.debug pattern_list.split("\r\n").count
      if log_message.raw_message.include? pattern then
      	log_message.ignored = true
      end
    end
  end
end
