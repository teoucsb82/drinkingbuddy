class PagesController < ApplicationController

  def home
    @city = request.location.city
    @city = nil if @city.blank?
  end
end