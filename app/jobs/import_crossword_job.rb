class ImportCrosswordJob < ApplicationJob
  queue_as :default
  retry_on CrosswordProviderError, attempts: 5

  def perform(crossword_intent, **params)
    crossword = CrosswordImporter.import(crossword_intent.data)
    logger.info "Imported crossword ##{crossword.id}"
  end
end
