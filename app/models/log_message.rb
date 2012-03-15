class LogMessage < ActiveRecord::Base
  belongs_to :log
  belongs_to :message_pattern

  validates :log, presence: true

  scope :ignored, where(ignored: true)
  scope :matched, where('message_pattern_id IS NOT NULL')

  def ignore!
    update_attribute(:ignored, true)
  end
  
end
