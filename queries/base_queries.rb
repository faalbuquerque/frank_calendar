require_relative '../config/data_base'

class BaseQueries
  def self.connect_to_db
    @connection = DataBase.connection
  end

  def self.close_connection
    @connection&.close
  end
end
