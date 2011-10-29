class Category
  attr_reader :categories

  CATEGORY_FILE = "../category.csv"

  def initialize categories
    @categories = categories
  end

  def self.load filename = CATEGORY_FILE
    categories = {}

    File.open(filename, 'r').each do |line|
      index, category_name = line.split(",")
      categories[index.to_i] = category_name.chomp
    end

    return Category.new(categories)
  end

  def get_category index
     if @categories.has_key?(index) != true
      raise ArgumentError , "index doesn't exists'"
    end
    return @categories[index]
  end
end




