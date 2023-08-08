class User < ApplicationRecord
  extend Devise::Models
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :consultants, class_name: 'Consultation', foreign_key: 'consultant_id'
  has_many :requesters, class_name: 'Consultation', foreign_key: 'requester_id'
  has_many :senders, class_name: 'Message', foreign_key: 'sender_id'
end