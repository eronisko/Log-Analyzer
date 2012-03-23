class Source < ActiveRecord::Base
  validates :name, :timestamp_definition, presence: true
  validates_uniqueness_of :name

  has_many :message_patterns, dependent: :destroy

  CUSTOM_FIELDS_COUNT = 4

  def apply_to_log(log)
    log.log_messages.each do |message|
      message_patterns.each do |pattern|
        if match = pattern.build_regexp.match(message.raw_message) then
        	logger.debug "matched #{message.raw_message} with #{pattern.build_regexp.to_s}"
        	matching_data = extract_data_from_message match

        	message.update_attributes(matching_data)
      	  message.update_attribute(:message_pattern_id, pattern.id)
      	  break
      	end
      end
    end
  end

  def find_custom_field_id_by_name(name)
    return name if name == "timestamp"

    1.upto(CUSTOM_FIELDS_COUNT) do |n|
      field = "field_#{n}"
      return field if send(field+"_name").eql? name 
    end
  end

  def get_custom_field_pattern(field_id)
    return send("#{field_id}_definition")
  end

  private

  # Extracts the data and creates a hash matching :field => "data"
  def extract_data_from_message(match)
    hash = Hash[match.names.zip(match.captures)].symbolize_keys
  end
end
