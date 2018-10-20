module Factory
  def find_by_id!(id)
    id_field = resource(:id_field)
    data = resource(:db).where(id_field => id).first
    raise 'Not Found' if data.nil?
    new(data)
  end

  def all
    resource(:db).all.map { |data| new(data) }
  end

  def store!(object)
    id_field = resource(:id_field)
    db = resource(:db)
    data = object.data.reject { |k, _| k == id_field }
    db.where(id_field => object.id).update(data)
  end

  def etl_fields
    {
      creation_date: Time.now,
      updated_at: Time.now,
      enabled: true
    }
  end

  def create!
    defaults = resource(:defaults).merge(etl_fields)
    id_field = resource(:id_field)
    db = resource(:db)
    id = db.insert(defaults)
    new(defaults.merge(id_field => id))
  end
end

module FactoryInstanceMethods
  attr_writer :data
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def id
    @data[self.class.resource(:id_field)]
  end
end
