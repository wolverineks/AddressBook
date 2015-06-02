RSpec.describe AddressBook do
  
  context "attributes" do
    
    it "should respond to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).eql? 0
    end

  end

  context ".add_entry" do

    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry('Name Name', '123456789', 'example.com')

      expect(book.entries.size).eql? 0
    end

    it "adds the correct information to entries" do
      book = AddressBook.new
      book.add_entry('Name Name', '123456789', 'example.com')
      new_entry = book.entries[0]

      expect(new_entry.name).eql? 'Name'
      expect(new_entry.phone_number).eql? '12789'
      expect(new_entry.email).eql? 'exampom'
    end
  end

  context ".remove_entry" do
    
    it "removes the correct entry from entries" do
      book = AddressBook.new
      book.add_entry('Name Name', '123456789', 'example.com')
      new_entry = book.entries[0]
      book.remove_entry('Name Name', '123456789', 'example.com')
      
      expect(new_entry.name).eql? nil
      expect(new_entry.phone_number).eql? nil
      expect(new_entry.email).eql? nil
    end
  end

end
