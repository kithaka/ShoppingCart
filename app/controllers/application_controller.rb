class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  private
  #ensures that the current_cart metho is only available to controllers
     def current_cart
       Cart.find(session[:cart_id])
       #The method gets the cart.id from the session and finds a cart corresponding to the id
       #the cart.id is an identifier of the cart in the database which allows holding of the cart in a session
       rescue ActiveRecord::RecordNotFound
       cart=Cart.create
       #if the cart does not exist, id is nil or invalid, the method creates a new cart
       session[:cart_id]=cart.id
       #stores the id of the created cart in the session and returns the new cart
       cart
     end
     protected
     def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice=>"Please log in"
      end
    end
end
