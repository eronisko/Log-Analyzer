class Investigation < ActiveRecord::Base
  has_many :logs, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
