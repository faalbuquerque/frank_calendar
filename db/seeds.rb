require 'pg'
require_relative '../config/data_base'

sql = <<-SQL
          INSERT INTO users(name, email, created_at, updated_at)
          VALUES('Maria', 'maria@frankcalendar.com', '#{DateTime.now.to_datetime}',
                 '#{DateTime.now.to_datetime}'), ('Joao', 'joao@frankcalendar.com',
                 '#{DateTime.now.to_datetime}', '#{DateTime.now.to_datetime}'),
                ('Ana', 'ana@frankcalendar.com', '#{DateTime.now.to_datetime}',
                 '#{DateTime.now.to_datetime}');
SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close
