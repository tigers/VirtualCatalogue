class Storage
  attr_reader :products, :quantity

  PRODUCTS_FILE = "../products.csv"

  #products file: id, barcode, name, brand, description, category, price, picture, location
  #quiantity file: id, quantity

  def initialize
    @products = []
    @quantity = {}
  end

  def load_products_file filename=PRODUCTS_FILE
    File.open(filename, 'r').each do |line|
      puts line #.split(",")
    end
  end
end