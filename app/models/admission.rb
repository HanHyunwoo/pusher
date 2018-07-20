class Admission < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room, counter_cache: true

  after_commit :join_chat_room_notification, on: :create

  def join_chat_room_notification
    Pusher.trigger('chat_room', 'join', self.as_json)
  end
end
