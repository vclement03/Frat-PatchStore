# coding: utf-8
class Item < ApplicationRecord
  belongs_to :order
  belongs_to :club, optional: true

  belongs_to :patch_type, optional: true

  attr_accessor :founder

  validates :value, presence: true
  validate :patch_type_allowed

  enum approval_status: [:approved, :refused]

  def odd?
    if self.club_id.nil?
      return false
    else
      # pas ghetto pentoute
      value.sub(/[AH]/, '').to_i.odd?
    end
  end


  before_validation do
    if club && club.patch_types.size == 1
      self.patch_type_id = club.patch_types.first.id
    end

    if self.founder == "1"
      self.patch_type = PatchType.find_by(name: 'founder')
    end
  end

  def founder?
    self.patch_type&.name == 'founder'
  end

  def full_text
    text = self.value

    if self.club_id
      text = self.club.name + ' ' + text
    end

    text
  end

  def official?
    not self.club_id.nil?
  end

  def patch_type_description
    if patch_type.name == "plain"
      Config.get("patch_#{patch_type.name}_odd_description")
    else
      Config.get("patch_#{patch_type.name}_description")
    end
  end

  private

  def patch_type_allowed
    if founder == "1" and
      if club_id.nil? or not club.patch_types.pluck(:name).include?('founder')
        errors.add(:founder, "n'est pas possible pour ce regroupement.")
      end
    end

    if official? and not club.validate_value(self.value)
      errors.add(:value, "ne resepecte pas les règlements de la Fraternité.")
    end
  end
end
