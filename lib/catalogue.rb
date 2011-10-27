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

  def get_product(product_id)
    if product_id == nil
      raise ArgumentError, "'product_id' cannot be nil"
    end

    product = nil

    @products.each do
      |p|
      if p.id == product_id
        product = p
        break
      end
    end

    if product == nil
      raise ArgumentError, "Cannot find a product ID which matches 'product_id'"
    end

    return product
  end

  def search(search_term, category_id = 0)
    if @products.count == 0
      return []
    end

    search_result = []
    search_term_str = search_term.to_s.downcase

    @products.each do
      |p|
      if ((p.id.to_s.downcase.include? search_term_str) ||
         (p.barcode.to_s.downcase.include? search_term_str) ||
         (p.name.downcase.include? search_term_str) ||
         (p.brand.downcase.include? search_term_str) ||
         (p.description.downcase.include? search_term_str) ||
         (p.location.downcase.include? search_term_str)) &&
         (category_id == 0 || p.category_id == category_id)

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

   def edit_product(product)

    if @products.index{|p| p.id == product.id} == nil
          raise ArgumentError, "'cannot edit, product' does not exists"
    end

  if product == nil
      raise ArgumentError, "Cannot edit a product ID which matches 'product_id'"
    end
    remove_product(product.id)
    add_product(product)
  end
end