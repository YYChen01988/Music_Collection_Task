require('pg')

require_relative("../db/sql_runner.rb")


class Artist
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i()
  end

  def self.all()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    return results.map { |artist| Artist.new(artist) }
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE artists SET (
    name) = ($1) WHERE id = $2"
    values = [@name]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist_searched = Artist.new(artist_hash)
    return artist_searched
  end

  def album()
    sql = "SELECT * FROM albums WHERE artist_id = $1 "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|album| Album.new(album)}
  end



end
