class Product

  #id, barcode, name, brand, description, category, price, picture, location

  def initialize(id, barcode, name, brand, description, category_id, price, picture, location)
    if(id == nil)
          raise ArgumentError , "id parameter is nil"
     end
    if( name == nil)
      raise ArgumentError , "name parameter is nil"
    end
    if (description == nil)
       raise ArgumentError , "description parameter is nil"
    end
    if (location == nil)
      raise ArgumentError , "location parameter is nil"
    end
    if (barcode == nil)
       raise ArgumentError , "barcode parameter is nil"
    end
    if(brand == nil)
      raise ArgumentError , "brand parameter is nil"
    end
    if(category_id == nil)
      raise ArgumentError , "category parameter is nil"
    end

    if(price == nil)
      raise ArgumentError , "price parameter is nil"
    end
    if(picture == nil)
      raise ArgumentError , "picture parameter is nil"
    end


    @name = name
    @description = description
    @location  = location
    @id = id.to_i
    @barcode = barcode
    @brand = brand
    @category_id = category_id.to_i
    @picture = picture
    @price = price
  end

 attr_accessor :id, :barcode, :name, :brand, :description, :category_id, :price, :picture, :location



end

