RSpec.describe Entry do

   context "attributes" do

     it "should respond to name" do
       entry = Entry.new("Name Name ", "123456789", "example.com")
       expect(entry).to respond_to(:name)
     end
 
     it "should respond to phone number" do
       entry = Entry.new("Name Name", "123456789", "example.com")
       expect(entry).to respond_to(:phone_number)
     end
 
     it "should respond to email" do
       entry = Entry.new("Name Name", "123456789", "example.com")
       expect(entry).to respond_to(:email)
     end
  end 

  context ".to_s" do
    
    it "prints an entry as a string" do
      entry = Entry.new("Name Name", "123456789", "example.com")
   
      expected_string = "Name: Name Name\nPhone Number: 123456789\nEmail: example.com"
    
      expect(entry.to_s).to eq(expected_string)
    end

  end
end
