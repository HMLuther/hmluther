class HomeController < ApplicationController

  def index
    @featured = Item.featured
  end

end
