require_relative 'base_queries'

class UsersQueries < BaseQueries
  def self.fetch_all
    begin
      connect_to_db

      sql = 'SELECT * FROM users'
      lines = @connection.exec(sql)

      lines.map do |line|
        {
          id: line['id'],
          name: line['name'],
          email: line['email'],
          created_at: line['created_at'],
          updated_at: line['updated_at']
        }
      end

    rescue => exception
      raise "#{exception.message} maybe no database?"
    ensure
      close_connection
    end
  end
end
