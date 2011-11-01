require 'product'

class Storage
  attr_reader :products, :quantity

  PRODUCTS_FILE = "../products.csv"
  QUANTITY_FILE = "../quantity.csv"

  #products file: id, barcode, name, brand, description, category, price, picture, location
  #quiantity file: id, quantity

  def initialize products, quantity
    @products = products
    @quantity = quantity
  end

  def add_product product
    @products.push(product)
  end

  def edit_product product
    @products.delete_if{|p| p.id == product.id}
    @products.push(product)
  end

  def get_quantity product_id
    if @quantity.has_key?(product_id) != true
      return 0
    end

    return @quantity[product_id]
  end

  def self.load products_file = PRODUCTS_FILE, quantity_file = QUANTITY_FILE
    products = []

    File.readlines(products_file).each do |line|
      product_fields = line.split("∴")
      p = Product.new(product_fields[0].to_i, *(product_fields[1..-1]) )
      products.push(p)
    end

    quantity = {}

    File.readlines(quantity_file).each do |line|
      product_id, product_quantity = line.split("∴")
      quantity[product_id.to_i] = product_quantity.to_i
    end

    return Storage.new(products, quantity)
  end

  def remove_product product_id
    @products.delete_if{|p| p.id == product_id}
  end

  def save products_file = PRODUCTS_FILE, quantity_file = QUANTITY_FILE
    p_file = File.open(products_file, 'w')

    @products.each do |p|
      p_file.puts("#{p.id}∴#{p.barcode}∴#{p.name}∴#{p.brand}∴#{p.description}∴#{p.category_id}∴#{p.price}∴#{p.picture}∴#{p.location}")
    end

    p_file.close

    q_file = File.open(quantity_file, 'w')

    @quantity.each do |p_id, quantity|
      q_file.puts("#{p_id}, #{quantity}")
    end

    q_file.close
  end

  def set_quantity product_id, quantity
    if @quantity.has_key?(product_id) != true
      raise ArgumentError , "product_id doesn't exists'"
    end

    @quantity[product_id] = quantity
  end
end