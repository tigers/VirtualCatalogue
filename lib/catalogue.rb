require 'product'

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
    if @products.index{|p| p.id==product.id} != nil
      raise ArgumentError, "'product' already exist"
    end

    @products.push(product)
  end

  def search(search_term)

  end

  def remove_product(product_id)
    if product_id == nil
      raise ArgumentError, "'product_id' cannot be nil"
    end

    # Check for existing product
    if @products.index{|p| p.id==product_id} == nil
      raise ArgumentError, "'product_id' does not exist"
    end

    # Remove appropriate product
    @products.delete_if{|p| p.id==product_id}
  end
end