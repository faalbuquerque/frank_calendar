require_relative '../queries/users_queries'
require_relative './model_base'
require 'bcrypt'

class User < ModelBase
  attr_accessor :id, :name, :email, :created_at, :updated_at

  validate :not_blank, :valid_email, :not_missing, :unique_email

  def initialize(hash)
    super
    @id = hash[:id]
    @name = hash[:name]
    @email = hash[:email]
    @password_digest = hash[:password_digest]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end

  def self.all
    UsersQueries.fetch_all.map { |user| new(user) }
  end

  def self.user_new(attributes = {})
    User.new(attributes)
  end

  def user_save
    errors << 'Não foi possível salvar!' and return false unless valid?

    UsersQueries.create(attributes)
  end

  def user_update(user_params)
    user_params = user_params.transform_keys(&:to_sym)

    user_params[:password_digest] = BCrypt::Password.create(user_params[:password]) if user_params[:password]
    user_params.each_key { |key| attributes[key] = user_params[key] }

    errors << 'Não foi possível atualizar!' and return false unless custom_valid?(:not_blank, :valid_email)

    UsersQueries.update(id, user_params)
  end

  def self.find(id)
    UsersQueries.find(id)
  end

  def self.find_by(attributes)
    UsersQueries.find_by(attributes).map { |user| new(user) }
  end

  def authenticate(password)
    BCrypt::Password.new(catch_password) == password
  end

  private

  def catch_password
    @password_digest
  end
end
