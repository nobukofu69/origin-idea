class Consultation < ApplicationRecord
  enum request_status: { not_requested: 0, requesting: 1, completed: 2 }
  enum talkroom_status: { not_created: 0, opened: 1, closed: 2 }
  belongs_to :consultant, class_name: 'User'
  belongs_to :requester, class_name: 'User'
  has_many :messages, dependent: :destroy, inverse_of: :consultation
  validates :request_content, presence: true

  # ログインユーザーが相談を依頼中､またはトークルームがオープン中の場合に trueを返すクラスメソッド
  def self.consulted?(user1, user2)
    where(requester: user1, consultant: user2)
      .exists?(['request_status = ? OR talkroom_status = ?',
                Consultation.request_statuses[:requesting],
                Consultation.talkroom_statuses[:opened]])
  end

  # 未読の依頼があればtrueを返すクラスメソッド
  def self.unread_request?(user)
    where(consultant: user, is_read: false).exists?
  end

  # 未読のメッセージがあればtrueを返すクラスメソッド
  def self.unread_message?(user)
    @user_consultations = Consultation.where(
      "(requester_id = :user_id OR consultant_id = :user_id) AND talkroom_status = :talkroom_status",
      user_id: user.id,
      talkroom_status: Consultation.talkroom_statuses[:opened]
    )

    @user_consultations.each do |consultation|
      return true if consultation.messages.where.not(sender: user).exists?(is_read: false)
    end

    # 未読のメッセージがなければfalseを返す
    false
  end

  # Consultationインスタンスのis＿readカラムが未読であることを判定及び出力するメソッド
  def unread_request_notification
    is_read ? '' : '未読あり'
  end

  # messageが存在しないことを判定および出力するメソッド
  def no_message_notification
    messages.empty? ? 'トークをはじめよう！' : ''
  end

  # トークルームに未読の受信メッセージがあることを判定および出力するメソッド
  def unread_message_notification(current_user)
    messages.where.not(sender: current_user).exists?(is_read: false) ? '未読メッセージがあります！' : ''
  end

  # ログインユーザー以外のユーザーを取得する
  def other_user(current_user)
    requester == current_user ? consultant : requester
  end

end
