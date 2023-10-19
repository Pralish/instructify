# frozen_string_literal: true

class Checkpoint < Node
  has_one :assessment, class_name: 'Assessments::Assessment', dependent: :destroy

  accepts_nested_attributes_for :assessment, allow_destroy: true
end
