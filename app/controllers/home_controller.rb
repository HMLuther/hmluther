class HomeController < ApplicationController

  def index
    @featured = Item.featured.shuffle
  end

end
