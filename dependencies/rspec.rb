Dir.glob('./controllers/*.rb').each { |file| require file }

Dir.glob('./spec/support/*.rb').each { |file| require file }

require './config/data_base'
