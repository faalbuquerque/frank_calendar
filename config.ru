Dir.glob('./controllers/*.rb').each { |file| require file }

run Sinatra::Application
