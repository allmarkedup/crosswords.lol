class TestImportJob < ApplicationJob
  queue_as :default

  def perform(number)
    intent = CrosswordIntent.new("/crosswords/quick/#{number}")
    ImportCrosswordJob.perform_now(intent)
  end
end
