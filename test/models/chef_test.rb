require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
    @chef = Chef.new(chef_name: "john", email: "john@example.com")
    end
   
   test "chef should be valid" do
   assert @chef.valid?
   end
   
   test "chefname should be present" do
   @chef.chef_name = ""
   assert_not @chef.valid?
   end
   
   test "chefname should not be too long" do 
       @chef.chef_name = "a" * 41
       assert_not @chef.valid?
   end
   
   test "chefname should not be too short" do 
       @chef.chef_name = "a" * 2
       assert_not @chef.valid?
   end
   
   test "email should be present" do
        @chef.email = ""
        assert_not @chef.valid?
   end
   
   test "email should not be too long" do 
        @chef.email = "a" * 106 
        assert_not @chef.valid?
   end
   
   test "email address should be unique" do 
       dup_chef = @chef.dup
       dup_chef.email = @chef.email.upcase
       @chef.save
       assert_not dup_chef.valid?
   end
    
    test "email validation should accept valid addressess" do
        valid_address = %w[user@eee.com R_TDD-DS@eee.hello.org one@example.com first.last@eem.au laura+joe@monk.cm]
        valid_address.each do |va|
        @chef.email = va
        assert @chef.valid?, '#{va.inspect} should be valid'
        end
    end
    
    test "email validation should reject valid addressess" do
        invalid_address = %w[user@eee,com eee.hello.org user.name@example eee@i_am_.com foo@ee+aar.com]
        invalid_address.each do |ia|
        @chef.email = ia
        assert_not @chef.valid?, '#{ia.inspect} should be invalid'
        end
    end

end