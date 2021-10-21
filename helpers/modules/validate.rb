module Validate
  def valid?
    return true unless blank_fields?

    attributes.map do |key, value|
      errors << "#{key}: não pode ficar em branco!" if value.strip.empty?
    end
    false
  end

  private

  def blank_fields?
    attributes.values.map(&:strip).include?('')
  end
end
