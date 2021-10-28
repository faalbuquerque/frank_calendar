require 'byebug'

module Validate
  def valid?
    return true if !blank_fields? && valid_email? && !missing_attributes?

    set_missing_errors if missing_attributes?
    set_email_errors if attributes['email'] && !valid_email?
    set_blank_errors

    false
  end

  private

  def set_missing_errors
    missing_attributes.each do |key|
      errors << "#{key}: campo faltando!"
    end
  end

  def set_email_errors
    errors << 'Email inválido!'
  end

  def set_blank_errors
    attributes.map do |key, value|
      message = "#{key}: não pode ficar em branco!"
      errors << message if known_attributes.include?(key) && value.strip.empty?
    end
  end

  def blank_fields?
    return false unless validate.include? :blank

    attributes.values.map(&:strip).include?('')
  end

  def valid_email?
    return true unless validate.include? :email

    !!(attributes['email'] =~ URI::MailTo::EMAIL_REGEXP)
  end

  def missing_attributes?
    return false unless validate.include? :missing

    attributes.keys != known_attributes
  end

  def missing_attributes
    known_attributes - attributes.keys
  end

  def known_attributes
    regex = /(?:^|(?=[^']).\b)(created_at|updated_at|id|errors|attributes)\b/
    @known_attributes ||= to_yaml.split.join(' ').gsub(regex, '')
                                 .delete(':').split('[]').pop.strip.split
  end
end
