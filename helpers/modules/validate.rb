module Validate
  def valid?
    return true if catch_validations

    set_errors_validations and false
  end

  private

  def set_errors_validations
    set_missing_errors if missing_attributes? && validate.include?(:not_missing)
    set_email_errors if attributes['email'] && not_valid_email? && validate.include?(:valid_email)
    set_blank_errors if validate.include?(:not_blank)
  end

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

  def not_blank?
    !attributes.values.map(&:strip).include?('')
  end

  def valid_email?
    !!(attributes['email'] =~ URI::MailTo::EMAIL_REGEXP)
  end

  def not_valid_email?
    !valid_email?
  end

  def not_missing?
    known_attributes.all? { |attribute| attributes.keys.include? attribute }
  end

  def missing_attributes?
    !not_missing?
  end

  def missing_attributes
    known_attributes - attributes.keys
  end

  def known_attributes
    regex = /(?:^|(?=[^']).\b)(created_at|updated_at|id|errors|attributes)\b/
    @known_attributes ||= to_yaml.split.join(' ').gsub(regex, '')
                                 .delete(':').split('[]').pop.strip.split
  end

  def catch_validations
    validate.all? { |symbol| send("#{symbol}?".to_sym) }
  end
end
