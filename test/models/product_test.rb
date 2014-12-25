require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive and less than 10,000" do
    product = Product.new(
        name: "My Book Title",
        description: "yyy",
        image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]
    product.price = 1
    assert product.valid?
    product.price = 10001
    assert product.invalid?, "product price must be no greater than 10,000"
  end

  # Helper method to test that we're validating the URL of the image
  def new_product(image_url)
    Product.new(
        name: "My Book Title",
        description: "yyy",
        price: 1,
        image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} should be valid"
    end
    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(
        name: products(:ruby).name,
        description: "yyy",
        price: 1,
        image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:name]
  end

  test "image url must be unique" do
    product = Product.new(
        name: "My Book Title",
        description: "yyy",
        price: 1,
        image_url: "ruby.png")  # A image_url already usec in fixtures
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:image_url]
  end
end
