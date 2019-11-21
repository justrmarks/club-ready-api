class Attending < ApplicationRecord
    belongs_to :event
    belongs_to :attendee, class_name: "User", foreign_key: "user_id"
    enum status: [:going, :interested]
end
