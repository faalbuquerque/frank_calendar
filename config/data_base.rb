require 'pg'
require 'yaml'
require 'erb'

class DataBase
  def self.connection
    PG.connect(environment_db_params)
  rescue PG::Error => e
    raise e.message
  end

  def self.environment_db_params
    data = ERB.new(File.read('config/database.yml')).result
    dictionary = [TrueClass, FalseClass, NilClass, Numeric, String, Array, Hash,
                  Symbol, Date, Time]

    db = YAML.safe_load(data, dictionary, [], true)
    db[ENV['DATABASE']] || db['development']
  end

  def self.clean_db
    sql = 'TRUNCATE TABLE users' if ENV['DATABASE'] == 'test'

    connection.exec(sql)
    connection&.close
  end
end
