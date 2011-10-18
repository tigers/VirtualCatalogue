require 'product'

class Storage
  attr_reader :products, :quantity

  PRODUCTS_FILE = "../products.csv"
  QUANTITY_FILE = "../quantity.csv"

  #products file: id, barcode, name, brand, description, category, price, picture, location
  #quiantity file: id, quantity

  def initialize
    @products = []
    @quantity = {}
  end

  def load_products_file filename=PRODUCTS_FILE
    File.open(filename, 'r').each do |line|
      temp = line.split(",")
      p = Product.new(*temp)
      @products.push(p)
    end
  end

  def load_quantity_file filename_quantity = QUANTITY_FILE
    File.open(filename_quantity, 'r').each do |line|
      id,q = line.split(",")
      @quantity[id.to_i] = q.to_i
    end
  end

  def get_quantity id
    return @quantity[id]
  end
end