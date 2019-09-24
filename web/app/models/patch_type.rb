class PatchType < ApplicationRecord
  has_many :clubs
  
  def self.descriptions
    keys = PatchType.all.map { |patch_type| "patch_#{patch_type.name}_description" }
    keys += %w{ patch_plain_odd_description patch_plain_even_description  }
    
    Config.where(key: keys).map { |config| [config.key, config.value] }.to_h
  end
end
