require 'pg'
require 'bcrypt'
require_relative '../models/user'

password = BCrypt::Password.create('123456')

maria = { name: 'Maria', email: 'maria@frankcalendar.com', password_digest: password }
UsersQueries.create(maria)

joao = { name: 'Joao', email: 'joao@frankcalendar.com', password_digest: password }
UsersQueries.create(joao)

ana = { name: 'Ana', email: 'ana@frankcalendar.com', password_digest: password }
UsersQueries.create(ana)
