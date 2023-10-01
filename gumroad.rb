require "json"
require "nokogiri"
require "csv"

CSV($stdout) do |csv|
  csv << ["title", "author", "subtitle", "link"]
  ARGV.each do |filename|
    doc = Nokogiri::HTML(File.read(filename))

    library_string = doc.at_css("script[data-component-name=\"LibraryPage\"]").content

    json = JSON.parse(library_string)
    json["results"].each do |r|
      name = r["product"]["name"]
      title, subtitle = name.split(/:\s+/, 2).map(&:strip)
      link = r["purchase"]["download_url"]
      creator = r["product"]["creator"]
      creator_name = creator ? creator["name"] : ""

      # blank column is for manually filling in categorisation
      csv << [title, creator_name, "", subtitle, link]
    end
  end
end



