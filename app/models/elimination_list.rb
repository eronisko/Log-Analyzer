class EliminationList < ActiveRecord::Base
  validates :name, :pattern_list, presence: true
  validates_uniqueness_of :name

  def filter_log_message(log_message)
    pattern_list.each_line do |pattern|
      if log_message.raw_message.include? pattern.chomp then
      	log_message.ignored = true
      end
    end
  end
end
