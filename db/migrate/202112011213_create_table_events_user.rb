require 'pg'
require_relative '../../config/data_base'

sql = <<-SQL
  CREATE TABLE events_users (
    id SERIAL PRIMARY KEY,
    user_id INT, FOREIGN key (user_id) REFERENCES users(id) ON DELETE CASCADE,
    event_id INT,FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
  );
SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close
