require 'pg'

sql = "CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        name varchar(200) NOT NULL,
        email varchar(200) NOT NULL,
        created_at date NOT NULL,
        updated_at date NOT NULL
      );"
begin
  connection = PG.connect(dbname: 'frankcalendar_development', host: 'db',
                         user: 'postgres', password: 'postgres')

  connection.exec(sql)

rescue PG::Error => e
  puts e.message
ensure
  connection.close if connection
end
