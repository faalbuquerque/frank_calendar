class Wizard
  @@messages = [
    'Gerando Bancos de Dados', 'Rodando Migrations',
    'Gerando Seeds', 'Finalizado!'
  ]

  @@msg_max_size = @@messages.max { |a, b| a > b ? -1 : a < b ? 0 : 1 }.size

  def self.show_splash
    puts File.open('./bin/splash.txt').read
  end

  def self.run_database_generate
    puts @@messages.first.center(@@msg_max_size + 41, '=')
    start = Time.now

    `docker-compose exec db createdb frankcalendar_development -U postgres`
    `docker-compose exec db createdb frankcalendar_test -U postgres`

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_migrations
    puts @@messages[1].center(@@msg_max_size + 41, '=')

    start = Time.now

    migrations = `ls -l db/migrate | awk '{print $9}'`
    migrations = migrations[1, (migrations.length - 2)].split("\n")

    migrations.each do |migration|
      `docker-compose exec web bash -c 'ruby db/migrate/#{migration}'`
      `docker-compose exec web bash -c 'DATABASE=test ruby db/migrate/#{migration}'`
    end

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_seeds
    puts @@messages[2].center(@@msg_max_size + 41, '=')
    start = Time.now

    `docker-compose exec web ruby db/seeds.rb`

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_closure
    puts @@messages.last.center(@@msg_max_size + 41, '=')
  end

  def self.display_time_to_process(final, start)
    puts "Etapa concluida em (#{(final - start).round(2)} s)\n\n"
  end
end
