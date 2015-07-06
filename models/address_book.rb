require_relative "entry.rb"
require "csv"

class AddressBook

  attr_accessor :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone, email)
    index = 0
    @entries.each do |entry|
      if name < entry.name
        break
      end
      index += 1
    end

    @entries.insert(index, Entry.new(name, phone, email))    
  end

  def remove_entry(name, phone, email)
    @entries.delete_if { |e| e.name == name && e.phone == phone && e.email == email }
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone"], row_hash["email"])
    end
  end

  # Search AddressBook.entries for a specific entry by name
  def binary_search(name, list=nil)
    list ||= entries
    
    return nil if list.empty?
    entry = list[list.length/2]
    return entry if entry.name == name

    if entry.name > name
      return binary_search(name, list[0,list.length/2])
    else
      return binary_search(name, list[list.length/2 + 1, list.length])
    end
  end

  def iterative_search(name)
    result = nil
    @entries.each do |entry|
      if entry.name == name
        result = entry
        break
      end
    end
    result
  end

end
