require 'pg'
require_relative '../../config/data_base'

sql = <<-SQL
          CREATE TABLE events (
              id SERIAL PRIMARY KEY,
              event_name varchar(200),
              event_location varchar(200),
              event_description varchar(200),
              start_date timestamptz,
              end_date timestamptz,
              user_id int NOT NULL, FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
            );
SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close
