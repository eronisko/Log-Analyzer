class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages, dependent: :destroy

  validates :name, :data_type, :file, :time_bias, :investigation,
            presence: true
  validates :time_bias, numericality: true
  validates_uniqueness_of :name, scope: :investigation_id

  # The data types currently accepted by the application
  VALID_DATA_TYPES = ['plaintext']

  def uploaded_file=(uploaded_file)
    self.file=uploaded_file.original_filename
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

  def apply_source source
    source.message_patterns.each do |message_pattern|
      regex_p = message_pattern.to_regexp
      regex_s = message_pattern.to_s
      matching_messages = log_messages.unmatched.matching_regex(regex_s)

      matching_messages.each do |message|
        message.extract_data_by_pattern regex_p, message_pattern
      end
    end
  end
end
