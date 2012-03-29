class LogMessage < ActiveRecord::Base
  belongs_to :log
  belongs_to :message_pattern

  validates :log, presence: true

  scope :ignored, where(ignored: true)
  scope :active, where(ignored: false)
  scope :matched, where{message_pattern_id != nil}
  scope :unmatched, where{message_pattern_id == nil}
  scope :matching_regex, ->(regex_string) {
    where('raw_message REGEXP ?', regex_string) } 

  def self.ignore_matching(ignore_list)
    ignore_patterns = ignore_list.to_like_patterns
    self.where{raw_message.like_any ignore_patterns}.update_all(ignored: true)
  end

  # Extracts the data into individual fields
  def extract_data_by_pattern(regexp, message_pattern)
    if match = regexp.match(raw_message) then
      # Creates a hash maching :field_x => data
      new_data = Hash[match.names.zip(match.captures)].symbolize_keys
      self.attributes = new_data
      self.message_pattern = message_pattern
      self.save
    end
  end

end
