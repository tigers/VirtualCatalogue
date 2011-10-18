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

    if @products.index{|p| p.id == product.id} != nil
      raise ArgumentError, "'product' already exists"
    end

    @products.push(product)
  end

  def search(search_term)
    if @products.count == 0
      return []
    end

    search_result = []
    search_term_str = search_term.to_s

    @products.each do
      |p|
      if p.id.to_s.include? search_term_str
        search_result.push(p)
        next
      end

      if p.barcode.to_s.include? search_term_str
        search_result.push(p)
        next
      end

      if p.name.include? search_term_str
        search_result.push(p)
        next
      end

      if p.brand.include? search_term_str
        search_result.push(p)
        next
      end

      if p.description.include? search_term_str
        search_result.push(p)
        next
      end

      if p.category.include? search_term_str
        search_result.push(p)
        next
      end

      if p.location.include? search_term_str
        search_result.push(p)
        next
      end
    end

    return search_result
  end

  def remove_product(product_id)
    if product_id == nil
      raise ArgumentError, "'product_id' cannot be nil"
    end

    if @products.index{|p| p.id == product_id} == nil
      raise ArgumentError, "'product_id' does not exist"
    end

    @products.delete_if{|p| p.id == product_id}
  end
end