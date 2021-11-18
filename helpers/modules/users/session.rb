module Authentication
  def sign_in(args)
    user = User.find_by(email: args[:email]).first

    if user&.authenticate(args[:password])
      hash = user.attributes

      hash.delete(:password_digest)

      hash
    else
      {}
    end
  end
end
