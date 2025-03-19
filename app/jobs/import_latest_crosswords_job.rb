class ImportLatestCrosswordsJob < ApplicationJob
  queue_as :default

  def perform
    latest = CrosswordProvider.latest
    latest.each.with_index(1) do |intent, i|
      ImportCrosswordJob.set(wait: i + (i * 2)).perform_later(intent)
    end

    Import.create
  rescue => error
    AdminMailer.with(
      error: error.to_s,
      context: error.respond_to?(:context) ? error.context : nil,
      data:
    ).failed_import.deliver_later
    raise error
  end
end
