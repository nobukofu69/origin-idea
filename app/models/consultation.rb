class Consultation < ApplicationRecord
  enum request_status: { not_requested: 0, requesting: 1, completed: 2 }
  enum talkroom_status: { not_created: 0, opened: 1, closed: 2 }
  belongs_to :consultant, class_name: 'User'
  belongs_to :requester, class_name: 'User'
  has_many :messages, dependent: :destroy, inverse_of: :consultation
  validates :request_content, presence: true

  # ログインユーザーが相談を依頼中､またはトークルームがオープン中の場合に trueを返すクラスメソッド
  def self.consulted?(current_user, user)
    where(requester: current_user, consultant: user)
      .exists?(['request_status = ? OR talkroom_status = ?',
                Consultation.request_statuses[:requesting],
                Consultation.talkroom_statuses[:opened]])
  end

  # 未読の依頼があればtrueを返すクラスメソッド
  def self.unread_request?(current_user)
    where(consultant: current_user, is_read: false).exists?
  end

  # Consultationインスタンスのis＿readカラムが未読であることを判定及び出力するメソッド
  def unread_request_notification
    is_read ? '' : '未読あり'
  end

  # messageが存在しないことを判定および出力するメソッド
  def no_message_notification
    messages.empty? ? 'トークをはじめよう！' : ''
  end

  # トークルームに未読のメッセージがあることを判定および出力するメソッド
  def unread_message_notification(current_user)
    messages.where.not(sender: current_user).exists?(is_read: false) ? '未読メッセージがあります！' : ''
  end

  # ログインユーザー以外のユーザーを取得する
  def other_user(current_user)
    requester == current_user ? consultant : requester
  end

end
