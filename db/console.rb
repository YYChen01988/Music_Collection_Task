require("pry")
require_relative("../models/album_collection")
require_relative("../models/artist")



Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' =>"Hermans Hermits"
  })
artist2 = Artist.new({
  'name' =>"The Zombies"
  })

artist1.save()
artist2.save()


album1 = Album.new({
  'title' =>"Blaze",
  'style' =>"Pop",
  'artist_id' =>artist1.id()
  })

album2 = Album.new({
  'title' =>"Odessey and Oracle",
  'style' =>"Rock",
  'artist_id' =>artist2.id()
  })

  album1.save()
  album2.save()








binding.pry
nil
