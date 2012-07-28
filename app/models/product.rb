class Product < ActiveRecord::Base
  default_scope :order =>'title'
  attr_accessible :description, :image_url, :price, :title
  validates :description, :image_url, :price, :title, :presence=>true
  validates :price, :numericality =>{:greater_than_or_equal_to =>0.01}
  validates :title, :uniqueness =>true
  has_many :line_times
  before_destroy :ensure_not_referenced_by_any_line_item
   private
 
     #ensure thar there are ot line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
         errors.add(:base, "Line Items Present")
         return false
      end
    end
end
