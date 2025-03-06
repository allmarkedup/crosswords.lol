class Import < ApplicationRecord
  class << self
    def latest
      Import.order(created_at: :desc).first
    end
  end
end
