class Product

  #id, barcode, name, brand, description, category, price, picture, location

  def initialize(name, description, location, id, barcode)
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

    @name = name
    @description = description
    @location  = location
    @id = id
    @barcode = barcode
  end

 attr_accessor :name, :description, :location, :id, :barcode



end

