class LogMessage < ActiveRecord::Base
  belongs_to :log

  validates(:log, presence: true)
  validates_associated :log

  def ignored?
    ignored
  end
end
