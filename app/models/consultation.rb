class Consultation < ApplicationRecord
  enum status: { not_requested: 0, requesting: 1, matching: 2, closed: 3 }
  belongs_to :consultant, class_name: "User"
  belongs_to :requester, class_name: "User"
  has_many :messages
  validates :request_content, presence: true

  # ログインユーザー以外のユーザーを取得する
  def other_user(current_user)
    requester == current_user ? consultant : requester
  end
end
