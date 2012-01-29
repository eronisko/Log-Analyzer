class LogMessage < ActiveRecord::Base
  belongs_to :log

  validates_associated :log
end
