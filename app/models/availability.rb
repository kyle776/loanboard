class Availability < ApplicationRecord
  belongs_to :board
  has_one :booker, :class_name => "User", :foreign_key => "id", :primary_key => "booked_by"

  validates :date, presence: true
  # validates :timeslot, presence: true
  validates :board_id, presence: true


  scope :available, -> { where(booked_by: nil) }
  scope :booked, -> {where.not(booked_by: nil) }

  def make_booking(user)
    self.booked_by = user.id
    self.booked_on = Time.now
    save
  end

  def cancel_booking_booked
    self.booked_by = nil
    self.booked_on = nil
    save
  end

  def available?
    booked_by == nil
  end

  def status
    booked_by.present? ? 'Booked' : 'Available'
  end

end
