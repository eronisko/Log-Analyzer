class Source < ActiveRecord::Base
  validates :name, :timestamp_definition, presence: true
  validates_uniqueness_of :name

  has_many :message_patterns, dependent: :destroy

  CUSTOM_FIELDS_COUNT = 1

  def apply_to_log(log)
    log.log_messages.each do |message|
      message_patterns.each do |pattern|
        if pattern.build_regexp.match(message.raw_message) then
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
end
