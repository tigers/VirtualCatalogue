class Catalogue
  attr_reader :products

  def initialize
    @products = []
  end

  def add_products(product)
    @products.push(product)
  end
end