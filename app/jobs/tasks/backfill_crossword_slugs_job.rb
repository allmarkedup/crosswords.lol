module Tasks
  class BackfillCrosswordSlugsJob < ApplicationJob
    def perform
      Crossword.where(slug: [nil, ""]).find_each do |crossword|
        crossword.update(slug: SlugGenerator.generate)
      end
    end
  end
end
