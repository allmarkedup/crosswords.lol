class Account < ApplicationRecord
  has_many :answers

  before_validation :assign_key

  private

  def assign_key
    self.key ||= AccountKeyGenerator.generate
  end
end
