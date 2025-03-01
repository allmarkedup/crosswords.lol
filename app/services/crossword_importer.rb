class CrosswordImporter
  class << self
    def import(crossword_intent)
      Crossword
        .create_with(**crossword_intent.data.slice(:crossword_type, :column_count, :row_count, :provider_published_on, :entries))
        .find_or_create_by(**crossword_intent.data.slice(:provider_name, :provider_reference))
    end
  end
end
