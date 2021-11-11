require 'pg'
require_relative '../../config/data_base'

sql = <<-SQL
          ALTER TABLE users ADD UNIQUE (email);
SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close
