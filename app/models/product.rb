class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01,
                                    less_than_or_equal_to: 10000 }
  validates :image_url, allow_blank: true, format: {
                          with: %r{\.(gif|jpg|png)\Z}i,
                          message: 'must be a URL for GIF, JPG or PNG image.'
                      }
  validates :image_url, uniqueness: true
  before_destroy :ensure_not_referenced_by_any_line_item

  # Returns latest product on the database
  def self.latest
    Product.order(:updated_at).last
  end

  private

    # Ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
