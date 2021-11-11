class Wizard
  MESSAGES = [
    'Gerando Bancos de Dados', 'Rodando Migrations',
    'Gerando Seeds', 'Finalizado!'
  ].freeze

  LARGER_MSG = MESSAGES.max do |a, b|
    next -1 if a > b
    next 0 if a < b

    1
  end

  MARGIN = LARGER_MSG.size + 41

  def self.show_splash
    puts File.open('./bin/splash.txt').read
  end

  def self.run_database_generate
    puts MESSAGES.first.center(MARGIN, '=')
    start = Time.now

    `docker-compose exec db createdb frankcalendar_development -U postgres`
    `docker-compose exec db createdb frankcalendar_test -U postgres`

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_migrations
    puts MESSAGES[1].center(MARGIN, '=')

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
    puts MESSAGES[2].center(MARGIN, '=')
    start = Time.now

    `docker-compose exec web ruby db/seeds.rb`

    final = Time.now
    display_time_to_process(final, start)
  end

  def self.run_closure
    puts MESSAGES.last.center(MARGIN, '=')
  end

  def self.display_time_to_process(final, start)
    puts "Etapa concluida em (#{(final - start).round(2)} s)\n\n"
  end
end
