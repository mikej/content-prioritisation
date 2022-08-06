require "json"
require "nokogiri"
require "csv"

ARGV.each do |filename|
  doc = Nokogiri::HTML(File.read(filename))

  library_string = doc.at_css("script[data-component-name=\"LibraryPage\"]").content

  json = JSON.parse(library_string)

  CSV($stdout) do |csv|
    json["results"].each do |r|
      name = r["product"]["name"]
      title, subtitle = name.split(/:\s+/, 2).map(&:strip)
      creator = r["product"]["creator"]
      creator_name = creator ? creator["name"] : ""

      # blank column is for manually filling in categorisation
      csv << [title, creator_name, "", subtitle]
    end
  end
end



