require_relative '../models/address_book.rb'

RSpec.describe AddressBook do
#################################################################################
  let(:book) { AddressBook.new }
 
  def search_entry_from_csv(name, phone, email)
    book.import_from_csv("entries.csv")
    entry = book.binary_search(name)
    expect(entry).to be_a Entry
    check_entry(entry, name, phone, email)
  end


  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eql expected_name
    expect(entry.phone).to eql expected_number
    expect(entry.email).to eql expected_email
  end  
#################################################################################
  context "attributes" do
    
    it "should respond to entries" do
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
      expect(book.entries.size).eql? 0
    end

  end
#################################################################################
  context "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
 
       expect(book.entries.size).to eq 1
    end
 
    it "adds the correct information to entries" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]
 
      expect(new_entry.name).to eq 'Ada Lovelace'
      expect(new_entry.phone).to eq '010.012.1815'
      expect(new_entry.email).to eq 'augusta.king@lovelace.com'
    end
  end
#################################################################################
  context "#remove_entry" do
    it "adds and removes only one entry to the address book" do
      entry = ['Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com']      

      book.add_entry(*entry)

      expect(book.entries.size).to eq 1

      book.remove_entry(*entry)

      expect(book.entries.size).to eq 0
    end
  end
##################################################################################
     # Test that AddressBook's .import_from_csv() method is working as expected
  context ".import_from_csv" do
    it "imports the correct number of entries" do
      book.import_from_csv("entries.csv")
      book_size = book.entries.size
 
      # Check the size of the AddressBook.entries
      expect(book_size).to eql 5
    end

    it "imports the 1st entry" do
      book.import_from_csv("entries.csv")
      entry_one = book.entries[0]
      check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      entry_two = book.entries[1]
      check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
    end
 
    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      entry_three = book.entries[2]
      check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
    end
 
    it "imports the 4th entry" do
      book.import_from_csv("entries.csv")
      entry_four = book.entries[3]
      check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
    end
 
    it "imports the 5th entry" do
      book.import_from_csv("entries.csv")
      entry_five = book.entries[4]
      check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end
  end
###############################################################################

  context ".import_from_csv" do
    it "imports the correct number of entries" do
      book.import_from_csv("entries_2.csv")
      book_size = book.entries.size
 
      # Check the size of the AddressBook.entries
      expect(book_size).to eql 5
    end

    it "imports the 1st entry" do
      book.import_from_csv("entries_2.csv")
      entry_one = book.entries[0]
      check_entry(entry_one, "Alice", "555-555-4854", "alice@blocmail.com")
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries_2.csv")
      entry_two = book.entries[1]
      check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries_2.csv")
      entry_three = book.entries[2]
      check_entry(entry_three, "Carol", "555-555-3660", "carol@blocmail.com")
    end    
  end
##############################################################################

  # Test the binary_search method
  context "#binary_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for non-existant entry that is similar to existant entry, Billy" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Billy")
      expect(entry).to be_nil
    end  

    it "searches AddressBook for Bill" do
      search_entry_from_csv("Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
      search_entry_from_csv("Bob", "555-555-5415", "bob@blocmail.com")
    end
 
    it "searches AddressBook for Joe" do
      search_entry_from_csv("Joe", "555-555-3660", "joe@blocmail.com")
    end
 
    it "searches AddressBook for Sally" do
      search_entry_from_csv("Sally", "555-555-4646", "sally@blocmail.com")
    end
 
    it "searches AddressBook for Sussie" do
      search_entry_from_csv("Sussie", "555-555-2036", "sussie@blocmail.com")
    end   

  end

###########################################################################

  context "#iterative_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill")
      expect entry.instance_of?(Entry)
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bob")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end
 
    it "searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Joe")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end
 
    it "searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Sally")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end
 
    it "searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Sussie")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end   

    it "searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Billy")
      expect(entry).to be_nil
    end 
  end

end
