class Log < ActiveRecord::Base
  belongs_to :investigation

  validates :name, :data_type, :path, :time_bias, presence: true
end
