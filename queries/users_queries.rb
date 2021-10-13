require_relative 'base_queries'

class UsersQueries < BaseQueries
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

  def self.create(hash)
    sql = "INSERT INTO users(#{hash.keys.join(', ')}, created_at, updated_at)
    VALUES(#{hash.values.map { |value| "'#{value}'" }.join(', ')},
    '#{DateTime.now.to_datetime}', '#{DateTime.now.to_datetime}');"

    connect_to_db

    @connection.exec(sql)
  rescue PG::Error => e
    raise "#{e.message} maybe no database?"
  ensure
    close_connection
  end
end
