require_relative '../queries/events_queries'
require_relative './model_base'

class Event < ModelBase
  attr_accessor :event_name, :event_location, :event_description, :start_date, :end_date, :user_id

  def initialize(hash)
    super

    validations :not_blank, :not_missing

    @id = hash[:id]
    @event_name = hash[:event_name]
    @event_location = hash[:event_location]
    @event_description = hash[:event_description]
    @start_date = hash[:start_date]
    @end_date = hash[:end_date]
    @user_id = hash[:user_id]
  end

  def self.event_new(attributes = {})
    Event.new(attributes)
  end

  def event_save
    errors << 'Não foi possivel criar evento!' and return false unless valid?

    EventsQueries.create(attributes)
  end

  def self.find_by_user_id(id)
    EventsQueries.events_find_by_user_id(id)
  end
end
