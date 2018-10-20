require 'sequel'
require 'safe_yaml'

module Services
  class << self
    def load_config!
      SafeYAML::OPTIONS[:default_mode] = :safe
      @config = SafeYAML.load_file('./config/config.yaml')
    end

    def database
      @database ||= Sequel.connect(@config['database']['endpoint'])
    end
  end
end
