require_relative 'factory'

class Event
  extend Factory
  include FactoryInstanceMethods
  extend Ant::DRY::ResourceInjector

  register(:id_field, :event_id)
  register(:defaults,
           monday: false,
           tuesday: false,
           wednesday: false,
           thursday: false,
           friday: false,
           saturday: false,
           sunday: false,
           begin_hour: Time.now,
           end_hour: Time.now).freeze

end
