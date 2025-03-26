class Admission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :department_id, type: BSON::ObjectId
  field :scheduled_date, type: DateTime
  field :cashless_hospitalization, type: Boolean

  belongs_to :patient
  has_one :department
end
