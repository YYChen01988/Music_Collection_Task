require("pg")

require_relative("../db/sql_runner.rb")

class AlbumCollection

  attr_accessor :title, :style
  attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @style = options['style']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (
    title, style, artist_id
    ) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @style, @artist_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    return results.map { |album| AlbumCollection.new(album) }
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE albums SET (
    title, style, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @style, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    album_searched = AlbumCollection.new(album_hash)
    return album_searched
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1 "
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    return Artist.new(results[0])
  end

end
