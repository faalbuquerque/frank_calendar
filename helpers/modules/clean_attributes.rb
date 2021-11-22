module CleanAttributes
  def clean_hash(hash)
    hash.include?(:password_digest || :password) ? hash.except(:password_digest || :password) : hash
  end

  def filtered_pass(hash)
    hash.include?(hash['password']) ? hash['password'] = 'FILTERED' : 'No password'
  end
end
