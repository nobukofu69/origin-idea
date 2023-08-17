class TalkroomChannel < ApplicationCable::Channel
  def subscribed
    # talkroom_channelからのストリーミングを開始する
    stream_from 'talkroom_channel'
  end

  def unsubscribed; end

  # クライアントがメッセージ送信に使うメソッド
  def speak(data)
    # クライアントからのデータをもとにmessageモデルを組み立てる
    message = current_user.senders.create!(sent_at: Time.now, consultation_id: data['consultation_id'],
                                           content: data['content'])

    # Messageモデルをレンダリングしてtalkroom_channelへブロードキャストする
    ActionCable.server.broadcast 'talkroom_channel', { message: render_message(message) }
  end

  private

  # Messageモデルをレンダリングするプライベートメソッド
  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: })
  end
end
