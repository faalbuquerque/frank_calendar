require_relative '../config/database.rb'

class BaseQueries
  def self.connect_to_db
    @connection = DataBase.connection
  end

  def self.close_connection
    @connection.close if @connection
  end
end
