class EliminationList < ActiveRecord::Base
  validates :name, :pattern_list, presence: true
  validates_uniqueness_of :name
end
