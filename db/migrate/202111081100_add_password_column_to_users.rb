require 'pg'
require_relative '../../config/data_base'

sql = <<-SQL
          ALTER TABLE users ADD COLUMN  password_digest VARCHAR(60) NOT NULL
SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close
