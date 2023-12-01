# frozen_string_literal: true

class Member < ApplicationRecord
  multi_tenant :organization

  include Invitable

  belongs_to :organization
  belongs_to :user

  delegate :full_name, :email, to: :user
end
