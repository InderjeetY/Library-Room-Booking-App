class Room < ApplicationRecord
  belongs_to :booking

  validates :room_no, :presence => true
  validates :building, :presence => true
  validates :size, :presence => true
end
