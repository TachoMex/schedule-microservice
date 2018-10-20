Sequel.migration do
  up do
    create_table(:assignation) do
      foreign_key  :event_id, :event
      foreign_key  :schedule_id, :schedule
      primary_key  %i[schedule_id event_id]
      DateTime     :creation_date, null: false
      DateTime     :updated_at, null: false
      TrueClass    :enabled, default: true
    end
  end
end
