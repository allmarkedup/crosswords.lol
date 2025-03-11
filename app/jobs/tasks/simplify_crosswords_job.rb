module Tasks
  class SimplifyCrosswordsJob < ApplicationJob
    def perform
      Crossword.find_each do |crossword|
        crossword.number = crossword.provider_reference.gsub("crosswords/quick/", "").to_i
        crossword.save
      end
    end
  end
end
