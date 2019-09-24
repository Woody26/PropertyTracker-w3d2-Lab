require('pg')

class PropertyTracker

  attr_accessor :address, :value, :bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @address = options['address']
    @value = options['value'].to_i()
    @bedrooms = options['bedrooms'].to_i()
    @year_built = options['year_built'].to_i()
  end

  def save()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql =
      "INSERT INTO property_trackers
      (address,
        value,
        bedrooms,
        year_built
        ) VALUES ($1, $2, $3, $4) RETURNING *"
        values = [@address, @value, @bedrooms, @year_built]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i
        db.close()
  end

  def update()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql =
    "UPDATE property_trackers SET
    (
      address,
      value,
      bedrooms,
      year_built
    ) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@address, @value, @bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM property_trackers WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def PropertyTracker.find(input_id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM property_trackers WHERE id = input_id "
    db.prepare("find", sql)
    orders = db.exec_prepared("find")
    db.close()
    return orders.map {|order| PropertyTracker.new(order)}
  end

  def PropertyTracker.delete_all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM property_trackers"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  def PropertyTracker.all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM property_trackers"
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    db.close()
    return orders.map {|order| PropertyTracker.new(order)}
  end


end
