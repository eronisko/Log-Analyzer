class LogMessage < ActiveRecord::Base
  belongs_to :log
  belongs_to :message_pattern

  validates :log, presence: true

  scope :ignored, where(ignored: true)
  scope :matched, where('message_pattern_id IS NOT NULL')

  def self.ignore_matching(ignore_list)
    ignore_patterns = ignore_list.to_like_patterns
    self.where{raw_message.like_any ignore_patterns}.update_all(ignored: true)
  end

  
end
