require_relative '../queries/users_queries'

class User
  attr_accessor :id, :name, :email, :created_at, :updated_at

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @email = hash[:email]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end

  def self.all
    UsersQueries.fetch_all.map { |user| new(user) }
  end

  def self.create(params)
    params if UsersQueries.create(params)
  end
end