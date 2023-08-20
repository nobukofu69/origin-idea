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

  # ログインユーザー以外のユーザーを取得する
  def other_user(current_user)
    requester == current_user ? consultant : requester
  end
end
