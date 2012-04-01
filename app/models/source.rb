class Source < ActiveRecord::Base
  validates :name, :timestamp_definition, presence: true
  validates_uniqueness_of :name

  has_many :message_patterns, dependent: :destroy

  CUSTOM_FIELDS_COUNT = 4

  def find_custom_field_id_by_name(name)
    return name if name == "timestamp"

    1.upto(CUSTOM_FIELDS_COUNT) do |n|
      field = "field_#{n}"
      return field if send(field+"_name").eql? name 
    end
  end

  def get_custom_field_pattern(field_id)
    return ".+?" if field_id == "timestamp"
    return send("#{field_id}_definition")
  end
end
