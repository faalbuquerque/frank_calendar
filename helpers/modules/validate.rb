module Validate
  NOT_USED = %i[@id @attributes @errors @created_at @updated_at @known_attributes].freeze

  def valid?
    return true if catch_validations

    set_errors_validations and false
  end

  private

  def set_errors_validations
    set_missing_errors
    set_email_invalid_errors
    set_registered_errors
    set_blank_errors
  end

  def check_missing_errors
    missing_attributes? && validate.include?(:not_missing)
  end

  def set_missing_errors
    missing_attributes.each { |key| errors << "#{key}: campo faltando!" } if check_missing_errors
  end

  def check_email_invalid_errors
    attributes['email'] && not_valid_email? && validate.include?(:valid_email)
  end

  def set_email_invalid_errors
    errors << 'Email inválido!' if check_email_invalid_errors
  end

  def check_registered_errors
    attributes['email'] && not_unique_email? && validate.include?(:unique_email)
  end

  def set_registered_errors
    errors << 'Este email já foi utilizado!' if check_registered_errors
  end

  def set_blank_errors
    attributes.map do |key, value|
      message = "#{key}: não pode ficar em branco!"
      errors << message if known_attributes.include?(key) && value.strip.empty? && validate.include?(:not_blank)
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

  def unique_email?
    !not_unique_email?
  end

  def not_unique_email?
    self.class.all.map { |obj| obj.attributes[:email] }.include?(attributes['email'])
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
    usable_attributes = instance_variables - NOT_USED

    @known_attributes ||= usable_attributes.map { |key| key.to_s.delete('@') }
  end

  def catch_validations
    validate.all? { |symbol| send("#{symbol}?".to_sym) }
  end
end
