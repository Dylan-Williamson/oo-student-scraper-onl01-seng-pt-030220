class Song

  attr_accessor :track, :artist, :key, :tempo, :url

  @@all = []

  def initialize(song_hash)
    song_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(songs_array)
    songs_array.each do |song_hash|
      Song.new(song_hash)
    end
  end

  def add_song_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end

