class MessagePattern < ActiveRecord::Base
  belongs_to :source

  validates :name, :pattern, :source, presence: true
  validates_uniqueness_of :name, scope: :source_id
  
  KEYWORD_IDENTIFIER = /@@(\w+?)@@/

  def to_regexp
    Regexp.new(self.to_s)
  end

  # Returns interpolated pattern as string
  def to_s
    replace_keywords_by_patterns
  end

  private
  
  # replaces the defined keywords by named captures for the appropriate custom
  # fields
  def replace_keywords_by_patterns
    pattern.gsub(KEYWORD_IDENTIFIER) { |match|
      name = match.sub(KEYWORD_IDENTIFIER, '\1')
      field   = source.find_custom_field_id_by_name(name)
      pattern = source.get_custom_field_pattern(field)
      "(?<#{field}>#{pattern})"
    }
  end

end
