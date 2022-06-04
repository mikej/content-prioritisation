require "json"

gumroad_json_string = File.read("gumroad.json")

json = JSON.parse(gumroad_json_string)

json["results"].each do |r| 
  creator = r["product"]["creator"]
  puts creator ? creator["name"] : ""
end



