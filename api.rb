require 'ant'
require 'ant/server/grape'
require 'ant/dry/resource_injector'
require 'cute_logger'
require 'grape'
require 'puma'

require_relative 'controllers/event'
require_relative 'controllers/schedule'

require_relative 'routes/events'
require_relative 'routes/schedules'

require_relative 'lib/services'

def configure_api!
  Services.load_config!
  db = Services.database
  Event.register(:db, db[:event])
  Schedule.register(:events, Event)
  Schedule.register(:db, db[:schedule])
  Schedule.register(:assignations, db[:assignation])
end

class ScheduleAPI < Grape::API
  include Ant::Server::GrapeDecorator
  version('v1', using: :header, vendor: :cutonala)
  prefix(:api)
  format(:json)

  mount Routes::Events
  mount Routes::Schedules
end
