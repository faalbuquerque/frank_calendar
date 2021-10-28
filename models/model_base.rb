require_relative '../helpers/modules/validate'

class ModelBase
  attr_accessor :attributes, :errors

  include Validate

  def initialize(hash)
    @attributes = hash
    @errors = []
  end

  # setter
  def self.validate(*validations)
    @@validate = validations
  end

  # getter
  def validate
    @@validate
  end
end
