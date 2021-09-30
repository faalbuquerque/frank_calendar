puts '====== Instalando dependências ======'

puts '====== Gerando Bancos de Dados ======'
system 'docker-compose exec db createdb frankcalendar_development -U postgres'
system 'docker-compose exec db createdb frankcalendar_test -U postgres'

puts '====== Criando Tabelas ======'
system 'docker-compose exec web irb ./db/migrate/create_table_users.rb'

puts '====== Gerando Seeds ======'
system 'docker-compose exec web irb ./db/seeds.rb'

puts '====== Finalizando! ======'
