class Log < ActiveRecord::Base
  belongs_to :investigation
  validates_associated :investigation

  validates :name, :data_type, :path, :time_bias, presence: true
  validates :time_bias, :numericality => true
  validates_uniqueness_of :name, :scope => :investigation_id


end
