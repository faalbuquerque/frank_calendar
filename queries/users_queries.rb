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

    return_clean_user(hash)
  end

  def self.user_sql_update(id, hash)
    "UPDATE users SET #{hash.map { |key, value| "#{key} = '#{value}'" }.join(', ')}, updated_at = '#{date}'
    WHERE id = #{id.to_i}\;"
  end

  def self.update(id, hash)
    connect_to_db and @connection.exec(user_sql_update(id, hash))

    return_clean_user(hash)
  rescue PG::Error => e
    raise "#{e.message} maybe no database?"
  ensure
    close_connection
  end

  def self.return_clean_user(hash_data)
    return [] if hash_data.nil?

    hash_data['password'] = 'FILTERED'

    hash_data.delete('password_digest')

    User.user_new(hash_data)
  end

  def self.find(id)
    connect_to_db
    begin
      sql = "SELECT * FROM users WHERE id = #{id} LIMIT 1;"
      result = @connection.exec(sql)
    rescue PG::Error => e
      raise "#{e.message} maybe no database?"
    ensure
      close_connection
    end

    return_clean_user(result.first)
  end

  def self.find_by(attributes)
    connect_to_db and @sql = 'SELECT * FROM users WHERE'

    treat_sql_attributes(attributes)
    connection_exec_sql(@sql)
  rescue PG::Error => e
    raise "#{e.message} maybe no database?"
  ensure
    close_connection
  end

  def self.treat_sql_attributes(attributes)
    attributes.each do |attribute|
      next if attribute.first == 'password'

      @sql += " #{attribute.first} = '#{attribute.last}'" if attributes.first == attribute
      @sql += " AND #{attribute.first} = '#{attribute.last}'" if attributes.first != attribute
    end
  end

  def self.connection_exec_sql(sql)
    lines = @connection.exec(sql)

    lines.map do |line|
      { id: line['id'], name: line['name'], email: line['email'],
        created_at: line['created_at'], updated_at: line['updated_at'],
        password_digest: line['password_digest'] }
    end
  end
end
