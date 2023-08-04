class User < ApplicationRecord
  extend Devise::Models
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :consultant, class_name: 'Consultation', foreign_key: 'consultant_id'
  has_many :requester, class_name: 'Consultation', foreign_key: 'requester_id'
end