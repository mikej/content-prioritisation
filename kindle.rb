require "nokogiri"
require "csv"
require "pry"

def clean(s)
  s.strip.gsub(/\s+/, " ")
end

CSV($stdout) do |csv|
  csv << %w[title author category subtitle link acquired_on]

  ARGV.each do |filename|
    doc = Nokogiri::HTML(File.read(filename))

    title_nodes = doc.css(".digital_entity_title")

    title_nodes.each do |title_node|
      title, subtitle = title_node.text.split(/:\s+/, 2).map { |s| clean(s) }

      author_node = title_node.next_element
      author = clean(author_node.text)

      # title_node will have an id like "content-title-ABCD2134" so we can extract the ASIN from this and use it
      # to build a product page URL
      asin = title_node["id"].match(/^content-title-(.+)$/).captures[0]
      link = "https://www.amazon.co.uk/gp/product/#{asin}"

      date_acquired_node = doc.css("#content-acquired-date-#{asin} text()")[1]
      date_string = date_acquired_node.text.strip
      acquired_on = Date.strptime(date_string, "%d %B %Y")

      # blank column is for manually filling in categorisation
      csv << [title, author, nil, subtitle, link, acquired_on]
    end
  end
end
