


class Category

  attr_reader :category

  CATEGORY_FILE = "../category.csv"


  def initialize
    @category = {}

  end

  def load_category_file filename_category = CATEGORY_FILE
    File.open(filename_category, 'r').each do |line|
      index,category_name = line.split(",")
      @category[index.to_i] = category_name

     end

  end

  def get_category index
    return @category[index]
  end




end




