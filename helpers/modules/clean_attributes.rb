module CleanAttributes
  def clean_hash(hash)
    hash = hash.except(:password_digest || :password) if hash.include?(:password_digest || :password)

    hash
  end

  def filtered_pass(hash)
    hash['password'] = 'FILTERED'
  end
end
