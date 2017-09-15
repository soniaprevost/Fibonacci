class User < ApplicationRecord
  include Clearance::User
  extend Enumerize

  SITUATIONS = %w(moved_in new_construction temporary_access).freeze

  enumerize :situation, in: SITUATIONS, scope: true

  validates :first_name, :last_name, :address, :situation, :pdl, presence: true
end
