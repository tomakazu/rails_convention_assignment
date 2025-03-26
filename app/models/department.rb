class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :serial_no, type: String
end
