class TalkroomChannel < ApplicationCable::Channel
  def subscribed
    #  ログインしているユーザーが、相談者またはコンサルタントとして参加している場合のみ
    if current_user.consultants.exists?(params[:consultation_id]) \
      || current_user.requesters.exists?(params[:consultation_id])
      stream_from "talkroom_channel_#{params[:consultation_id]}"
    end
  end

  def unsubscribed; end

  def speak(data)
    # クライアントからのデータをもとにmessageモデルを組み立てる
    # 現在ログインしているユーザーのidを送信者idとして保存する
    message = current_user.senders.create!(sent_at: Time.current, consultation_id: data['consultation_id'],
                                           content: data['content'])

    # talkroom_channelへブロードキャストする
    ActionCable.server.broadcast "talkroom_channel_#{params[:consultation_id]}", { message: render_message(message) }
  end

  private

  # Messageモデルをレンダリングするプライベートメソッド
  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: })
  end
end
