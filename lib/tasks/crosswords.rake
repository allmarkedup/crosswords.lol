namespace :crosswords do
  desc "Queues jobs to import all the latest crosswords for a source"
  task :import_latest, [:source_name] => [:environment] do |t, args|
    source = "sources/#{args[:source_name]}_source".camelize.constantize
    source.latest.each.with_index(1) do |params, i|
      ImportCrosswordJob.set(wait: i + (i * 2)).perform_later(args[:source_name], **params)
    end
  end

  desc "Import Guardian quick crosswords"
  task :import_guardian_quick, [:start_number, :end_number] => [:environment] do |t, args|
    args[:start_number].upto(args[:end_number]).with_index(1) do |number, i|
      ImportCrosswordJob.set(wait: i + (i * 2)).perform_later(:guardian_quick, path: "/crosswords/quick/#{number}")
    end
  end
end
