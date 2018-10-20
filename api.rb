require 'ant/dry/resource_injector'

require_relative 'controllers/event'
require_relative 'controllers/schedule'

require_relative 'lib/services'

def configure_api!
  Services.load_config!
  db = Services.database
  Event.register(:db, db[:event])
  Schedule.register(:db, db[:schedule])
  Schedule.register(:assignations, db[:assignation])
end
