class ImportLatestGuardianQuickCrosswordsJob < ApplicationJob
  queue_as :default

  def perform
    provider = Guardian::QuickCrosswordProvider
    provider.latest.each.with_index(1) do |intent, i|
      ImportCrosswordJob.set(wait: i + (i * 2)).perform_later(intent)
    end
  end
end
