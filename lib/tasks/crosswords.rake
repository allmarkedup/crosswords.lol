namespace :crosswords do
  desc "Queues jobs to import all the latest crosswords for a source"
  task :import_latest_dry_run, [:provider_name] => [:environment] do |t, args|
    provider = CrosswordProvider.resolve(args[:provider_name])
    latest = provider.latest
    errors = []
    latest.each do |intent|
      intent.hydrate
      sleep 5
    rescue CrosswordProviderError
      errors << CrosswordProviderError
    end
    puts <<~TEXT.strip
      ++++++++++++++++++++++++++++++++
      Import complete:
      #{latest.size - errors.size} #{"successes".pluralize(latest.size - errors.size)}
      #{errors.size} #{"error".pluralize(errors.size)}
      ++++++++++++++++++++++++++++++++
    TEXT
  end
end
