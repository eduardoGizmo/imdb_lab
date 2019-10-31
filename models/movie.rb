# require('pg')
require_relative('../db/sql_runner')



class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @budget = options["budget"].to_i
  end

  def save()
    sql = "INSERT INTO movies (title, genre, budget) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

  def final_budget
    sql = "SELECT castings.fee FROM movies
    INNER JOIN castings
    ON movie_id = castings.movie_id
    WHERE movie_id = $1"
    values = [@id]
    fee = SqlRunner.run(sql, values)[0]
    return @budget - fee["fee"].to_i
  end

  def stars_by_movie
    sql = "SELECT stars.* FROM stars
    INNER JOIN castings
    ON stars.id = castings.star_id
    WHERE movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql,values)
    return stars.map{|star| Star.new(star)}
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

 def update()
   sql = "UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4"
   values = [@title, @genre, @budget, @id]
   SqlRunner.run(sql, values)
 end

 def self.all()
   sql = "SELECT * FROM movies"
   result = SqlRunner.run(sql)
   return result.map{|movie| Movie.new(movie)}
 end

end
