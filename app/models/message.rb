class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :consultation
  validates :content, presence: true
end
