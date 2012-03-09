class LogMessage < ActiveRecord::Base
  belongs_to :log

  validates(:log, presence: true)
  validates_associated :log

  scope :ignored, where(ignored: true)

  def ignored?
    ignored
  end

  def ignore!
    update_attribute(:ignored, true)
  end
end
