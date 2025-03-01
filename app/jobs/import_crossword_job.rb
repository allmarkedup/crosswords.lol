class ImportCrosswordJob < ApplicationJob
  queue_as :default

  def perform(source_name, **params)
    source = "sources/#{source_name}_source".camelize.constantize
    data = source.fetch(**params)
    if data.present?
      crossword = source.import(data)
      logger.info "Imported crossword ##{crossword.id}"
    end
  rescue => error
    logger.error error
  end
end
