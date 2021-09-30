require 'byebug'
require 'pg'

class DataBase

  def self.connection
    begin
      PG.connect(environment_db_params)
    rescue => exception
      raise exception.message
    end
  end

  def self.environment_db_params
    db = {
      development: {
        dbname: 'frankcalendar_development',
        host: 'db',
        user: 'postgres',
        password: 'postgres'
      },
      test:{
        dbname: 'frankcalendar_test',
        host: 'db',
        user: 'postgres',
        password: 'postgres'
      }
    }

#se nao tiver [ENV['DATABASE'] usar o db[:development]
    db[ENV['DATABASE'].to_sym] || db[:development]
  end
end
