namespace :crosswords do
  namespace :export do
    desc "Export crosswords to JSON"
    task crosswords: :environment do
      crosswords_data_path = Rails.root.join("db/data/crosswords.json")
      crosswords_data = Crossword.all.map do |crossword|
        crossword.serializable_hash.except("created_at", "updated_at", "id").as_json
      end
      crosswords_json = crosswords_data.to_json
      File.write(crosswords_data_path, crosswords_json)
    end
  end
end
