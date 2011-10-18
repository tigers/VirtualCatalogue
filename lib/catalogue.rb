class Catalogue
  attr_reader :products

  def initialize
    @products = []
  end

  def add_product(product)
    if product == nil
      raise ArgumentError, "'product' cannot be nil"
    end

    # Check for existing product

    @products.push(product)
  end

  def search(search_term)

  end

  def remove_product(product)
    if product == nil
      raise ArgumentError, "'product' cannot be nil"
    end

    # Remove appropriate product
  end
end