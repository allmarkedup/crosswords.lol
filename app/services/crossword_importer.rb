class CrosswordImporter
  class << self
    def import(data)
      Crossword
        .create_with(**data.slice(:crossword_type, :column_count, :row_count, :provider_published_on, :entries))
        .find_or_create_by(**data.slice(:provider_name, :provider_reference))
    end
  end
end
