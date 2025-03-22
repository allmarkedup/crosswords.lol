module Test
  module Utils
    class << self
      def seed_data(name)
        data_file = Rails.root.join("db/data/#{name.to_s.delete_suffix(".json")}.json")
        JSON.parse(data_file.read).map(&:deep_symbolize_keys)
      end
    end
  end
end
