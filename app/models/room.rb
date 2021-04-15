class Room < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :user_rooms
end
