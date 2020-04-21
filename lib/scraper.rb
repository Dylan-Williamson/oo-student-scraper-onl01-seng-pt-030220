require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    songs = []
    index_page.css("div.searchResultList.row.main-row").each do |card|
      card.css("div.row main-row").each do |song|
        song_info_url = "#{song.attr('a.href')}"
        song_track = song.css('row search-track-name').text
        song_artist = song.css('div.row search-artist-name').text
        song_key = song.css('div.row search-attribute-value').text.scan(/\d+|\D+/)[0]
        song_tempo = song.css('div.row search-attribute-value').text.scan(/\d+|\D+/)[3]
        songs << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_slug)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end
end