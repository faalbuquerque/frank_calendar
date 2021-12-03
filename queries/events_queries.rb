require_relative 'base_queries'

class EventsQueries < BaseQueries
  def self.event_sql(hash)
    "INSERT INTO events(#{hash.keys.join(', ')})
    VALUES(#{hash.values.map { |value| "'#{value}'" }.join(', ')});"
  end

  def self.create(hash)
    begin
      connect_to_db and @connection.exec(event_sql(hash))
    rescue PG::Error => e
      raise "#{e.message} maybe no database?"
    ensure
      close_connection
    end

    hash
  end

  def self.events_find_by_user_id(id)
    connect_to_db
    begin
      events_sql = "SELECT * FROM events WHERE user_id = #{id.to_i};"
      result_events = @connection.exec(events_sql)
    rescue PG::Error => e
      raise "#{e.message} maybe no database?"
    ensure
      close_connection
    end
    result_events.map { |event| event }
  end
end
