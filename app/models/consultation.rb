class Consultation < ApplicationRecord
  belongs_to :consultant, class_name: "User"
  belongs_to :requester, class_name: "User"
end
