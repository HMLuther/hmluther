class HomeController < ApplicationController

  def index
    @featured = ItemDecorator.decorate_collection(Item.featured).shuffle
  end

end
