class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages

  validates_associated :investigation
  validates :name, :data_type, :path, :time_bias, presence: true
  validates :time_bias, :numericality => true
  validates_uniqueness_of :name, :scope => :investigation_id


  # Imports a file into the DB, extracting the messages line by line
  # Currently only handling plaintext files
  def import_to_db(path)
    file_handle = File.open(path, "r")
    file_handle.lines.each do |line|
      message = LogMessage.new(:log_id => id,
                               :raw_message => line)
      message.save
    end
  end

end
