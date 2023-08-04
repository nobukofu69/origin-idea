class Consultation < ApplicationRecord
  enum status: { not_requested: 0, requesting: 1, matching: 2, closed: 3 }
  belongs_to :consultant, class_name: "User"
  belongs_to :requester, class_name: "User"
end
