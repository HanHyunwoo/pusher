class Admission < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room, counter_cache: true

  after_commit :join_chat_room_notification, on: :create
  after_commit :exit_chat_room_notification, on: :destroy
  def join_chat_room_notification
    Pusher.trigger('chat_room', 'join', self.as_json)
    Pusher.trigger("chat_room_#{self.chat_room_id}",
      'join',
      self.as_json.merge({email: self.user.email,
        chat_room: self.chat_room.as_json}))
  end

  def exit_chat_room_notification
    Pusher.trigger('chat_room', 'exit', self.as_json)
    Pusher.trigger("chat_room_#{self.chat_room_id}",
      'exit',
      self.as_json.merge({email: self.user.email,
        chat_room: self.chat_room.as_json}}))
  end
end
