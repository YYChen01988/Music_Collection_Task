require("pry")
require_relative("../models/album_collection")
require_relative("../models/artist")



AlbumCollection.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' =>"Hermans Hermits"
  })
artist1.save()


album1 = AlbumCollection.new({
  'title' =>"Blaze",
  'style' =>"Pop",
  'artist_id' =>artist1.id()
  })
  album1.save()







binding.pry
nil
