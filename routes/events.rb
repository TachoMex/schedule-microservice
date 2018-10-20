module Routes
  class Events < Grape::API
    namespace :events do
      get do
        Event.all
      end

      post do
        Event.create!
      end

      route_param :event_id do
        get do
          Event.find_by_id(params['event_id'])
        end

        put do
          Event.find_by_id(params['event_id'])
        end
      end
    end
  end
end
