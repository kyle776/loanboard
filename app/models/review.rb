class Review < ApplicationRecord
  belongs_to :board
  belongs_to :user
  validates :content, presence: true
  validates :board_id, presence: true
  validates :user_id, presence: true
end
