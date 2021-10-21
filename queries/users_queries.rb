require_relative 'base_queries'

class UsersQueries < BaseQueries
  def self.date
    DateTime.now.to_s
  end

  def self.fetch_all
    connect_to_db

    lines = @connection.exec('SELECT * FROM users')

    lines.map do |line|
      { id: line['id'], name: line['name'], email: line['email'],
        created_at: line['created_at'], updated_at: line['updated_at'] }
    end
  rescue PG::Error => e
    raise "#{e.message} maybe no database?"
  ensure
    close_connection
  end

  def self.user_sql(hash)
    "INSERT INTO users(#{hash.keys.join(', ')}, created_at, updated_at)
    VALUES(#{hash.values.map { |value| "'#{value}'" }.join(', ')},
    '#{date}', '#{date}');"
  end

  def self.create(hash)
    begin
      connect_to_db and @connection.exec(user_sql(hash))
    rescue PG::Error => e
      raise "#{e.message} maybe no database?"
    ensure
      close_connection
    end
    User.user_new(hash.merge({ created_at: date, updated_at: date }))
  end
end
