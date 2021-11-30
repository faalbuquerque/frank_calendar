# require 'pg'
# require_relative '../../config/data_base'

# sql = <<-SQL
#           CREATE table events_duration (
#             id SERIAL PRIMARY KEY,
#             init_date date,
#             init_hour time,
#             end_date date,
#             end_hour time,
#             event_id int NOT NULL,
#             FOREIGN KEY (event_id) 
#               REFERENCES events (id)
#           );

# SQL

# connection = DataBase.connection
# connection.exec(sql)

# connection&.close