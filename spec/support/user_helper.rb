module UserHelper
  def user_create(name, email, password)
    pass_encrypt = BCrypt::Password.create(password)
    params = { name: name.to_s, email: email.to_s, password_digest: pass_encrypt }

    UsersQueries.create(params)
  end

  def user_login(email, password)
    params_login = { email: email.to_s, password: password.to_s }.to_json

    post '/users/login', params_login
  end
end
