require 'pg'
require 'bcrypt'
require_relative '../models/user'
require_relative '../models/event'

password = BCrypt::Password.create('123456')

maria = { name: 'Maria', email: 'maria@frankcalendar.com', password_digest: password }
UsersQueries.create(maria)

joao = { name: 'Joao', email: 'joao@frankcalendar.com', password_digest: password }
UsersQueries.create(joao)

ana = { name: 'Ana', email: 'ana@frankcalendar.com', password_digest: password }
UsersQueries.create(ana)

ana = User.find_by(name: 'Ana')
event_ana = { event_name: 'Evento da ana', event_location: 'online', event_description: 'Um evento da ana',
              start_date: '2021-12-01', end_date: '2021-12-02', user_id: ana.first.id }
EventsQueries.create(event_ana)

event_ana = { event_name: 'Segundo da ana', event_location: 'online', event_description: 'Segundo evento da ana',
              start_date: '2021-12-02 09:30"', end_date: '2021-12-02 11:30', user_id: ana.first.id }
EventsQueries.create(event_ana)

maria = User.find_by(name: 'Maria')
event_maria = { event_name: 'Evento da maria', event_location: 'link aqui', event_description: 'Um evento da maria',
                start_date: '2021-12-02 14:40', end_date: '2021-12-02 16:40', user_id: maria.first.id }
EventsQueries.create(event_maria)
