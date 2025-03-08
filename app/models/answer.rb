class Answer < ApplicationRecord
  belongs_to :account
  belongs_to :crossword

  serialize :values, coder: JsonCoder, default: -> { {} }

  before_save :set_synced_at

  def as_json(options = {})
    super.except("account_id", "created_at", "updated_at").merge({"synced_at" => synced_at_timestamp})
  end

  def synced? = synced_at.present?

  private

  def set_synced_at
    if updated_at != created_at
      self.synced_at = Time.zone.now
    end
  end

  def synced_at_timestamp
    (attributes["synced_at"].to_f * 1000).to_i if attributes["synced_at"]
  end
end
