class EliminationList < ActiveRecord::Base
  validates :name, :pattern_list, presence: true
  validates_uniqueness_of :name

  def filter_log_message(log_message)
    # TODO needs to account for \r\n as well as \n
    pattern_list.split("\n").each do |pattern|
      if log_message.raw_message.include? pattern then
      	log_message.ignored = true
      end
    end
  end
end
