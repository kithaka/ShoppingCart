class StoreController < ApplicationController
	skip_before_filter :authorize
  def index
    @products = Product.all
    @cart = current_cart
    #the above makes the @cart object available in the index view
    #current_cart available in the application controller

  end
end
