class LocationTag < ActiveRecord::Base
  belongs_to :locationable, :polymorphic => true

  validates :address, :presence => true

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def self.distance(loc1, loc2)
    Geocoder::Calculations.distance_between([loc1.latitude,loc1.longitude], [loc2.latitude,loc2.longitude])
  end

  def distance(loc2)
    LocationTag.distance(self, loc2)
  end

  def user
    return User.find(locationable_id) if locationable_type == User.name
  end

end
