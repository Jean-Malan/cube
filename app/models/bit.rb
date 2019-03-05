class Bit < ApplicationRecord

  belongs_to :profile

  def self.get_all_profile_bits(id)
    bits = self.all.where(profile_id: id)
  end
end
