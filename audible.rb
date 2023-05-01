require "nokogiri"
require "csv"

ARGV.each do |filename|
	doc = Nokogiri::HTML(File.read(filename))

    # title_nodes = doc.css(".bc-list-item .bc-size-headline3")
    library_entries = doc.css(".adbl-library-content-row")

  CSV($stdout) do |csv|
      csv << ["Title", "Author", "Subtitle"]
	  library_entries.each do |entry_node|
        title_node = entry_node.css(".bc-size-headline3")
        title, subtitle = title_node.text.strip.split(/:\s+/, 2)
        author_nodes = entry_node.css(".authorLabel a")
        authors = author_nodes.map(&:text).join(", ")

        csv << [title, authors, subtitle]
	  end
  end
end
