require "nokogiri"
require "csv"
require "pry"

def clean(s)
  s.strip.gsub(/\s+/, " ")
end

ARGV.each do |filename|
  doc = Nokogiri::HTML(File.read(filename))

  title_nodes = doc.css(".digital_entity_title")

  CSV($stdout) do |csv|
    title_nodes.each do |title_node|
      title, subtitle = title_node.text.split(/:\s+/, 2).map { |s| clean(s) }
      author = clean(title_node.next_element.text)

      # blank column is for manually filling in categorisation
      csv << [title, author, "", subtitle]
    end
  end
end
