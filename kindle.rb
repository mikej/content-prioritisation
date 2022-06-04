require "nokogiri"
require "csv"

ARGV.each do |filename|
	doc = Nokogiri::HTML(File.read(filename))
	
	title_nodes = doc.css(".digital_entity_title")
	
  CSV($stdout) do |csv|
	  title_nodes.each do |title_node|
      title, subtitle = title_node.text.split(/:\s+/, 2)
      author = title_node.next_sibling.text
      
      csv << [title, subtitle, author]
	  end
  end
end
