module CleanAttributes
  def clean_hash(hash)
    hash.except(:password_digest, 'password_digest')
  end

  def filtered_pass(hash)
    if hash.include?('password_digest')
      hash['password'] = 'FILTERED'
    else
      'No password'
    end
  end
end
