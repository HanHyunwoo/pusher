class Admission < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room, counter_cache: true
end
