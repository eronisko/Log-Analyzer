class Log < ActiveRecord::Base
  belongs_to :investigation
  has_many :log_messages

  validates_associated :investigation
  validates :name, :data_type, :file, :time_bias, presence: true
  validates :time_bias, :numericality => true
  validates_uniqueness_of :name, :scope => :investigation_id

  after_create import_to_db(params[:log][:uploaded_file])

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

end
