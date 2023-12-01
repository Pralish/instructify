# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :assessment_attempts, class_name: 'Assessments::Attempt'

  has_many :members

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_not_signed_up_yet?
    members.where.not(invitation_accepted_at: nil).any?
  end
end
