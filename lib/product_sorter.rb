class Product_Sorter
  def self.sort products, field = :id, order = :ascending
    case field
      when :id
        products.sort!{|p1, p2| p1.id.to_i <=> p2.id.to_i}
        products.reverse! if order == :descending
      when :price
        products.sort!{|p1,p2| p1.price.to_f <=>p2.price.to_f}
        products.reverse! if order == :descending
      when :name
        products.sort!{|p1, p2| p1.name.downcase<=>p2.name.downcase}
        products.reverse! if order == :descending
      when :brand
        products.sort!{|p1,p2| p1.brand.downcase<=>p2.brand.downcase}
        products.reverse! if order == :descending
      else
        products.sort!{|p1, p2| p1.id.to_i <=> p2.id.to_i}
        products.reverse! if order == :descending
    end
    return products
  end
end