class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room

  after_commit :chat_message_notification, on: :create

  def chat_message_notification
    Pusher.trigger("chat_room_#{self.chat_room_id}", #채팅방 이름
      'chat', # 이벤트
      self.as_json.merge({email: self.user.email})) # 데이터
  end
end
