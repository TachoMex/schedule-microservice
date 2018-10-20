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
    validate_colission(event)
    db = self.class.resource(:assignations)
    data = self
           .class
           .etl_fields
           .merge(event_id: event.id, schedule_id: @data[:schedule_id])
    db.insert(data)
  end

  def validate_colission(event)
    raise 'Conflict found with event' if colission?(event)
  end

  def all_events
    events_class = self.class.resource(:events)
    columns = events_class.resource(:db).columns
    self.class
        .resource(:assignations)
        .inner_join(:event, %i[event_id])
        .where(schedule_id: id)
        .select { columns.map { |column| Sequel[:event][column].as(column) } }
        .map { |event| events_class.new(event) }
  end

  def colission?(event)
    return false if @data[:allow_overlap]
    all_events.any? { |event_b| event.collide?(event_b) }
  end
end
