require_relative 'factory'

class Schedule
  extend Factory
  include FactoryInstanceMethods
  extend Ant::DRY::ResourceInjector

  register(:id_field, :schedule_id)
  register(:defaults,
           begin_date: Time.now,
           end_date: Time.now,
           endless: false,
           allow_overlap: false).freeze

  def attach_event(event)
    db = self.class.resource(:assignations)
    data = self
           .class
           .etl_fields
           .merge(event_id: event.id, schedule_id: @data[:schedule_id])
    db.insert(data)
  end
end
