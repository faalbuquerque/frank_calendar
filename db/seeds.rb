require 'pg'

sql = "INSERT INTO users(name, email, created_at, updated_at)
          VALUES('Maria', 'maria@frankcalendar.com',
                  '#{DateTime.now.to_datetime}',
                  '#{DateTime.now.to_datetime}'
                ),
                ('Joao', 'joao@frankcalendar.com',
                  '#{DateTime.now.to_datetime}',
                  '#{DateTime.now.to_datetime}'
                ),
                ('Ana', 'ana@frankcalendar.com',
                  '#{DateTime.now.to_datetime}',
                  '#{DateTime.now.to_datetime}'
                );"
begin
  connection = PG.connect(dbname: 'frankcalendar_development', host: 'db',
                         user: 'postgres', password: 'postgres')
  connection.exec(sql)
rescue => exception
  puts e.message
ensure
  connection.close if connection
end
