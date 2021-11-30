require 'pg'
require_relative '../../config/data_base'

sql = <<-SQL
          CREATE TABLE events (
            id SERIAL PRIMARY KEY,
            event_name varchar(200),
            event_participants varchar(200),
            event_location varchar(200),
            event_files varchar(200),
            event_owner varchar(200),
            event_description varchar(200),
            user_id int NOT NULL,
            FOREIGN KEY (id) 
              REFERENCES users (id)
          );

SQL

connection = DataBase.connection
connection.exec(sql)

connection&.close




# CREATE TABLE events (

#   id SERIAL PRIMARY KEY,
#   event_name varchar(200),
#   event_participants varchar(200),
#   event_location varchar(200),
#   event_files varchar(200),
#   event_owner varchar(200),
#   event_description varchar(200),
#   user_id int NOT NULL,

#   FOREIGN KEY (user_id)
#     REFERENCES users (id)
# );