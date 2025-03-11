class ImportLatestCrosswordsJob < ApplicationJob
  queue_as :default

  def perform
    CrosswordProvider.latest.each.with_index(1) do |intent, i|
      ImportCrosswordJob.set(wait: i + (i * 2)).perform_later(intent)
    end

    Import.create
  end
end
