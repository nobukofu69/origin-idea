class Consultation < ApplicationRecord
  enum request_status: { not_requested: 0, requesting: 1, completed: 2}
  enum talkroom_status: { not_created: 0, opened: 1, closed: 2}
  belongs_to :consultant, class_name: "User"
  belongs_to :requester, class_name: "User"
  has_many :messages
  validates :request_content, presence: true

  # ログインユーザーが相談を依頼していない場合に trueを返すクラスメソッド
  def self.not_consulted?(current_user, user)
    where(requester: current_user, consultant: user)
      .where('request_status = ? OR talkroom_status = ?', :requesting, :opened)
      .exists?.!
  end

  # ログインユーザー以外のユーザーを取得する
  def other_user(current_user)
    requester == current_user ? consultant : requester
  end
end
