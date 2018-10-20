Sequel.migration do
  up do
    create_table(:schedule) do
      primary_key :schedule_id, auto_increment: true
      DateTime     :begin_date, null: false
      DateTime     :end_date, null: false
      TrueClass    :endless, default: false
      TrueClass    :allow_overlap, default: false
      DateTime     :creation_date, null: false
      DateTime     :updated_at, null: false
      TrueClass    :enabled, default: true
    end
  end
end
