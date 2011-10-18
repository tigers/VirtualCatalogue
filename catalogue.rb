class Catalogue
  attr_reader :products

  def initialize
    @products = []
  end

  def add_product(product)
    if product == nil
      raise ArgumentError, "'product' cannot be nil"
    end

    @products.push(product)
  end
end