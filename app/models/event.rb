class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_guests
  has_one :location_tag, :as => :locationable

  attr_accessor :event_type

  def self.find_by_search_params(params)
    results = LocationTag.near(params[:address], params[:radius].to_i)
                         .where(:locationable_type => "Event")
                         .map(&:locationable_id)
    return Event.where(:id => results)
  end

  def self.set_time(date_string)
    date_array = date_string.split("/")
    yy = date_array[2]
    mm = date_array[0]
    dd = date_array[1]
    date_string = "#{yy}-#{mm}-#{dd}"
    return DateTime.parse(date_string)
  end

  def event_type
    return self.private? ? "Private Event" : "Public Event"
  end

  def process_params(params)
    date = params[:start_time]
    hour = params["start_time(4i)"].to_i
    minute = params["start_time(5i)"].to_i
    self.start_time = DateTime.new(date.year, date.month, date.day, hour, minute, 0, 0)
    self.private = params["private"] == "yes"
  end

  def update_coordinates
    self.update_attributes!(:latitude => self.location_tag.latitude,
                            :longitude => self.location_tag.longitude)
  end
end
