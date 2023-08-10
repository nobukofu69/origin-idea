class User < ApplicationRecord
  extend Devise::Models
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :consultants, class_name: 'Consultation', foreign_key: 'consultant_id'
  has_many :requesters, class_name: 'Consultation', foreign_key: 'requester_id'
  has_many :senders, class_name: 'Message', foreign_key: 'sender_id'

  def age
    now = Time.current.to_date
    birth_date = self.birthdate
    age = now.year - birth_date.year

    # 生年月日が今日の日付より後だった場合、年齢を1引く
    if now < birth_date.change(year: now.year)
      age -= 1
    end

    age
  end
end