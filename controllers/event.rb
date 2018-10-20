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

  def clean_time(time)
    Time.new(0, 1, 1, time.hour, time.min)
  end

  def clean_begin
    clean_time(@data[:begin_hour])
  end

  def clean_end
    clean_time(@data[:end_hour])
  end

  def collide?(event)
    range = (clean_begin..clean_end)
    range.cover?(event.clean_begin) || range.cover?(event.clean_end)
  end
end
