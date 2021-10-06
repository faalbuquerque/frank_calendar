require 'pg'
require_relative '../../config/data_base'

sql = <<-SQL
          CREATE TABLE users (id SERIAL PRIMARY KEY, name varchar(200) NOT NULL,
          email varchar(200) NOT NULL, created_at date NOT NULL, updated_at date NOT NULL);
SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close
