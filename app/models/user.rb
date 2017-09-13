class User < ApplicationRecord
  include Clearance::User

  validates :first_name, :last_name, :address, :situation, :pdl, presence: true
end
