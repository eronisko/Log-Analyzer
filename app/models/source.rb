class Source < ActiveRecord::Base
  validates :name, :timestamp_definition, presence: true
  validates_uniqueness_of :name

  has_many :message_patterns, dependent: :destroy
end
