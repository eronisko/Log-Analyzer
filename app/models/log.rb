class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages, dependent: :destroy
  belongs_to :ignore_list
  belongs_to :source

  validates :name, :data_type, :file, :time_bias, :investigation, 
            presence: true
  validates :time_bias, numericality: true
  validates_uniqueness_of :name, scope: :investigation_id
  validates :message_delimiter, length: { minimum: 1 } 

  # The data types currently accepted by the application
  VALID_DATA_TYPES = ['plaintext']

  def uploaded_file=(uploaded_file)
    self.file=uploaded_file.original_filename
  end

  def applied_ignore_list=(applied_ignore_list)
    log_messages.unignore!
    if !applied_ignore_list.empty? then
      @ignore_list = IgnoreList.find(applied_ignore_list)
      log_messages.ignore_matching @ignore_list
      self.ignore_list = @ignore_list
    else 
      self.ignore_list = nil
    end
  end

  def applied_ignore_list
    ignore_list_id
  end

  def applied_source=(applied_source)
    log_messages.unmatch!
    if !applied_source.empty? then
      @source = Source.find(applied_source)
      apply_source @source
      self.source = @source
    else
      self.source = nil
    end
  end

  def applied_source
    source_id
  end

  # Currently only handling plaintext files
  def import_to_db(uploaded_file)
    delimiter_regex = Regexp.new(message_delimiter)
    file_handle = uploaded_file.read
    raw_message = String.new
    file_handle.lines.each do |line|
      raw_message << line
      if raw_message.sub!(delimiter_regex,"") then
        message = LogMessage.new( :log_id => id,
                                  :raw_message => raw_message)
        message.save
        raw_message = ""
      end
    end
  end

  private

  def apply_source source
    source.message_patterns.each do |message_pattern|
      regex_p = message_pattern.to_regexp
      regex_s = message_pattern.to_s

      log_messages.active.unmatched.each do |message|
        message.extract_data_by_pattern regex_p, message_pattern
      end
    end
  end
end
