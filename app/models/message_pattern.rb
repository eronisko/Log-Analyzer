class MessagePattern < ActiveRecord::Base
  belongs_to :source

  validates :name, :pattern, :source, presence: true
  validates_uniqueness_of :name, scope: :source_id
end
