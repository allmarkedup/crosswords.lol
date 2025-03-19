class ImportCrosswordJob < ApplicationJob
  queue_as :default
  retry_on CrosswordProviderError, attempts: 3 if Rails.env.production?

  def perform(crossword_intent, **params)
    data = crossword_intent.data
    Crossword
      .create_with(**data.slice(:column_count, :row_count, :published_at, :entries))
      .find_or_create_by(**data.slice(:provider_name, :number))
    logger.info "Imported crossword ##{data[:number]}"
  rescue => error
    AdminMailer.with(
      error: error.to_s,
      context: error.respond_to?(:context) ? error.context : nil,
      data:
    ).failed_import.deliver_later
    raise error
  end
end
