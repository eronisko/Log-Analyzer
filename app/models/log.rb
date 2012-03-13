class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages, dependent: :destroy

  validates :name, :data_type, :file, :time_bias, presence: true
  validates :time_bias, numericality: true
  validates_uniqueness_of :name, scope: :investigation_id

  # The data types currently accepted by the application
  VALID_DATA_TYPES = ['plaintext']

  def uploaded_file=(uploaded_file)
    self.file=uploaded_file.original_filename
  end

  def ignore_list
  end

  # Currently only handling plaintext files
  def import_to_db(uploaded_file)
    file_handle = uploaded_file.read
    file_handle.lines.each do |line|
      message = LogMessage.new(:log_id => id,
                               :raw_message => line)
      message.save
    end
  end

end
