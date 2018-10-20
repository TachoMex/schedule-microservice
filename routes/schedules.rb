module Routes
  class Schedules < Grape::API
    namespace :events do
      get do
        Schedule.all
      end

      post do
        Schedule.create!
      end

      route_param :event_id do
        get do
          Schedule.find_by_id(params['event_id'])
        end

        put do
          Schedule.find_by_id(params['event_id'])
        end
      end
    end
  end
end
