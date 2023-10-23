# frozen_string_literal: true

module Assessments
  class AnswerOption
    include ActiveModel::Model

    attr_accessor :index, :value, :_destroy

    def marked_for_destruction?
      false
    end

    def [](key)
      instance_variable_get("@#{key}")
    end

    def []=(key, value)
      instance_variable_set("@#{key}", value)
    end
  end
end
