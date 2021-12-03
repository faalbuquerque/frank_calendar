require_relative '../helpers/modules/validate'

class ModelBase
  attr_accessor :attributes, :errors

  attr_reader :validate

  include Validate

  def initialize(hash)
    @attributes = hash.transform_keys(&:to_sym)
    @errors = []
  end

  # setter
  def validations(*validations)
    @validate = validations
  end
end
