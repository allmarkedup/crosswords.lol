class RefreshCrosswordSlugsJob < ApplicationJob
  def perform
    Crossword.find_each do |crossword|
      crossword.update(slug: SlugGenerator.generate(crossword.entries.to_json))
    end
  end
end
