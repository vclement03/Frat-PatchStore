class Config < ApplicationRecord
  validates :key, uniqueness: true

  def self.get(key)
    Config.find_by(key: key)&.value
  end
end
