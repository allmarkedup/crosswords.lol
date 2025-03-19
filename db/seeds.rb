# Crosswords data
crosswords_json = Rails.root.join("db/data/crosswords.json").read
crosswords_data = JSON.parse(crosswords_json)

crosswords_data.each do |crossword|
  Crossword.create_with(crossword).find_or_create_by(number: crossword["number"])
end
