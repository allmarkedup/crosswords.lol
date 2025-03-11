class ImportCrosswordsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    start_number, end_number = (args[0] > args[1]) ? args.reverse : args

    start_number.upto(end_number).with_index(1) do |number, i|
      intent = CrosswordIntent.new("/crosswords/quick/#{number}")
      ImportCrosswordJob.set(wait: i + (i * 2)).perform_later(intent)
    end
  end
end
