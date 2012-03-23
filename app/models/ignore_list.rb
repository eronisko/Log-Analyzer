class IgnoreList < ActiveRecord::Base
  validates :name, :pattern_list, presence: true
  validates_uniqueness_of :name

  def to_like_patterns
    pattern_list.each_line.collect { |pattern| "%#{pattern.chomp}%" }
  end
end
