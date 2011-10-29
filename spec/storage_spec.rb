require 'rspec'
require '../lib/storage'
require '../lib/product'

describe Storage do
  let(:products_filename) {"../products_test.csv"}
  let(:quantity_filename) {"../quantity_test.csv"}

  before :all do
    create_dummy_products
    create_dummy_quantity
  end

  def create_dummy_products
     File.open(products_filename, 'w') do |f|
       f.puts("1,12345678,lcd tv,sony,lcd tv,TV,1000,1.jpg,level2")
       f.puts("2,55555555,bike XYZ,oxford,super bike,SPORTS,500,2.jpg,level1")
     end
  end

  def create_dummy_quantity
    File.open(quantity_filename,'w') do |fq|
      fq.puts("1,5")
      fq.puts("2,15")
    end
  end

  let(:storage) { Storage.load(products_filename, quantity_filename) }

  context "About products" do
    it "should raise an exception if the file products.csv doesn't exist" do
      lambda {
        Storage.load('anyfile.csv', quantity_filename)
      }.should raise_exception()
    end

    it "should raise an exception if the file quantity.csv doesn't exist" do
      lambda {
        Storage.load(products_filename, 'anyfile.csv')
      }.should raise_exception()
    end

    it "should not raise an exception if the file products.csv exists and the quantity.csv file exists" do
      lambda {
        Storage.load(products_filename, quantity_filename)
      }.should_not raise_exception()
    end


    it "should load the contents of the file into array products" do
      storage.should have(2).products
    end

    it "should contain only product" do
      storage.products.each do | p |
        p.should be_an_instance_of Product
      end
    end

    it "should write the changes made to the products array to products.csv" do
      product = Product.new("22", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.add_product(product)
      products_before = storage.products
      storage.save(products_filename, quantity_filename)
      products_after = Storage.load(products_filename, quantity_filename).products

      equal_record_count = products_before.length == products_after.length
      equal_record_content = true

      for i in 0..products_before.length-1
        p_b = products_before[i]
        p_a = products_after[i]

        if (
            p_b.id == p_a.id &&
            p_b.barcode == p_a.barcode &&
            p_b.name == p_a.name &&
            p_b.brand == p_a.brand &&
            p_b.description == p_a.description &&
            p_b.category_id == p_a.category_id &&
            p_b.price == p_a.price &&
            p_b.picture == p_a.picture &&
            p_b.location.chomp == p_a.location.chomp
        ) == false
          equal_record_content = false
          break
        end
      end

      (equal_record_count && equal_record_content).should == true
    end
  end

  context "About quantity" do
    it "should load the contents of the file into array quantity" do
      storage.should have(2).quantity
    end
    it "should return 0 when an incorrect product_id is given" do
      q = storage.get_quantity(345)
      q.should == 0
    end

    it "should return quantity given the id" do
      storage.get_quantity(2).should == 15
    end
    it "should raise and exception when an incorrect product_id is given" do
      lambda{
        storage.set_quantity(345, 45)
      }.should raise_exception()
    end

    it "should quantity to given product_id " do
      storage.set_quantity(1, 30)
      storage.get_quantity(1).should == 30
    end
  end

  context "Editing functions" do
    it "should not raise an exception while trying to add products to products.csv file" do
      lambda {
        product = Product.new("23", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
        storage.add_product(product)
      }.should_not raise_exception()
    end

    it "should contain added product" do
      product = Product.new("24", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.add_product(product)
      exists = false
      storage.products.each do |p|
        if p.id.to_i == product.id.to_i
          exists = true
          break
        end
      end
      exists.should == true
    end

    it "should not raise an exception when trying to remove products from products.csv" do
      product = Product.new("25", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.add_product(product)
      lambda {
        storage.remove_product(25)
      }.should_not raise_exception()
    end

    it "should remove the specified product" do
      product = Product.new("26", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.add_product(product)
      product_id = 26
      storage.remove_product(product_id)
      exists = false
      storage.products.each do
        |p|
        if p.id == product_id
          exists = true
          break
        end
      end

      exists.should == false
    end

    it "should not raise an exception when trying to edit products from products.csv" do
      existing_product = Product.new("27", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.add_product(existing_product)
      edited_product = Product.new("27", "23452345", "mac", "apple", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      lambda {
        storage.edit_product(edited_product)
      }.should_not raise_exception()
    end

    it "should edit the specified product" do
      existing_product = Product.new("28", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.add_product(existing_product)
      changed_product = Product.new("28", "23452345", "mac", "apple", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
      storage.edit_product(changed_product)

      changed = false
      storage.products.each do |p|
        if p.id == changed_product.id
          if p.name == changed_product.name && p.brand == changed_product.brand
            changed = true
            break
          end
        end
      end

      changed.should == true
    end
  end
end



