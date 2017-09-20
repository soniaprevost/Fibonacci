class User < ApplicationRecord
  include Clearance::User
  include AASM
  extend Enumerize

  SITUATIONS = %w(moved_in new_construction temporary_access).freeze

  enumerize :situation, in: SITUATIONS, scope: true

  validates :first_name, :last_name, :address, presence: true, if: -> { aasm_state == 'with_basic_details' }
  validates :situation, :pdl, presence: true, if: -> { aasm_state == 'with_technical_details' }

  aasm do
    state :with_empty_profil, initial: true
    state :with_basic_details
    state :with_technical_details

    event :fill_basic_details do
      transitions from: :with_empty_profil, to: :with_basic_details
    end
    event :fill_technical_details do
      transitions from: :with_basic_details, to: :with_technical_details
    end
  end
end
