module Squabble
  module TablesConcern
    extend ActiveSupport::Concern

    SYSTEM_TABLE_NAMES = ["ar_internal_metadata", "schema_migrations"]

    included do
      before_action :assign_tables
    end

    def assign_tables
      @table_names = ActiveRecord::Base.connection.tables.filter { !_1.in?(SYSTEM_TABLE_NAMES) }
    end
  end
end
