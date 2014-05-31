class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
  #implements a form select option
  validates :name, :address, :email, :pay_type, :presence =>true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  has_many :line_items, :dependent => :destroy

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id=nil
  		line_items<<item
  		#we set the line_item cart_id to nil to prevent an exception when destroying the cart
  		#we add each item to the collection of line items
  	end
  end
end
