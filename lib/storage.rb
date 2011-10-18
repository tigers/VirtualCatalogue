class Storage
  attr_reader :products, :quantity

  def initialize
    @products = []
    @quantity = {}
  end
end