require_relative('./models/casting.rb')
require_relative('./models/movie.rb')
require_relative('./models/star.rb')
require('pry')

Movie.delete_all()

movie1 = Movie.new("title" => "Batman", "genre" => "Super Hero",
  "budget" => 1000000)
movie1.save
movie2 = Movie.new("title" => "Lalaland", "genre" => "Musical",
  "budget" => 2000000)
movie2.save
movie3 = Movie.new("title" => "Trainspotting", "genre" => "Dramady",
  "budget" => 3000000)
movie3.save

star1 = Star.new("first_name" => "George", "last_name" => "Clooney")
star1.save
star2 = Star.new("first_name" => "Emma", "last_name" => "Stone")
star2.save
star3 = Star.new("first_name" => "Ewan", "last_name" => "McGregor")
star3.save


casting1 = Casting.new("movie_id" => movie1.id, "star_id" => star1.id, "fee" => 2000)
casting1.save
casting2 = Casting.new("movie_id" => movie2.id, "star_id" => star2.id, "fee" => 5000)
casting2.save
casting3 = Casting.new("movie_id" => movie3.id, "star_id" => star3.id, "fee" => 9000)
casting3.save

binding.pry
nil
