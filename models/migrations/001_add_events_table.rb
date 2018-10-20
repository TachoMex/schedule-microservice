Sequel.migration do
  up do
    create_table(:event) do
      primary_key :event_id, auto_increment: true
      TrueClass :monday, default: false
      TrueClass :tuesday, default: false
      TrueClass :wednesday, default: false
      TrueClass :thursday, default: false
      TrueClass :friday, default: false
      TrueClass :saturday, default: false
      TrueClass :sunday, default: false
      Time     :begin_hour, null: false
      Time     :end_hour, null: false
      DateTime :creation_date, null: false
      DateTime :updated_at, null: false
      TrueClass :enabled, default: true
    end
  end
end
