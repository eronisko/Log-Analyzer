class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages

  def import_to_db
    path='/var/tmp/access_combined.log'

    file_handle = File.open(path, "r")
    file_handle.lines.each do |line|
      message = LogMessage.new(:log_id => id,
                               :raw_message => line)
      message.save
    end

  end
end
