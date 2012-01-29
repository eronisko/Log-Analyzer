class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages
end
