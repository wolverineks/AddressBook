require_relative "../models/address_book"

class MenuController
  attr_accessor :address_book
 
  def initialize
    @address_book = AddressBook.new
  end
####################################################################
  def main_menu
    options = {
      1 => :view_all_entries,
      2 => :view_entry,
      3 => :create_entry,
      4 => :search_entries_menu,
      5 => :read_csv,
      6 => :detonate,
      7 => :exit
    }

    puts "Main Menu - #{@address_book.entries.count} entries"

    options.each do |option|
      puts "#{option[0]} - #{option[1].to_s.gsub(/_/, " ").split.map(&:capitalize).join(" ")}"
    end

    print "Enter your selection: "
 
    selection = gets.to_i
    puts "You picked #{selection}"

    if options.keys.include?(selection)
      method(options[selection]).call
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end

  end
####################################################################
  def view_all_entries
    @address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      entry_submenu(entry)
    end
 
    system "clear"
    puts "End of entries"
    main_menu   
  end
####################################################################
  def view_entry
    system "clear"
    puts "Which entry?"

    selection = gets.to_i
    puts "You picked #{selection}"


    if (selection > 0 && selection < @address_book.entries.length + 1)
      entry = @address_book.entries[selection -1]
      puts entry
      puts ""
      main_menu
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end
####################################################################
  def create_entry
    system "clear"
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp
 
    @address_book.add_entry(name, phone, email)
    system "clear"
    puts "New entry created"

    main_menu
  end
####################################################################
  def search_entries_menu
    puts "b - Binary Search"
    puts "i - Iterative Search"

    print "Enter your selection: "

    selection = gets.chomp

    case selection

      when "b"
       system "clear"
       binary_search
      when "i"
       system "clear"
       iterative_search
      else
        system "clear"
        puts "#{selection} is not a valid input"
        search_entries_menu
    end
  end
#################################################################### 
  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp
 
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end
 
    begin
      entry_count = @address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end
####################################################################
  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    
    print "Enter your selection: "

    selection = gets.chomp
 
    case selection

    when "n"
      system "clear"
    when "d"
      system "clear"
      delete_entry(entry)
    when "e"
      system "clear"
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end
####################################################################
  def binary_search
    system "clear"
    puts "Enter name:"
    name = gets.chomp

    match = @address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end
####################################################################
  def iterative_search
    system "clear"
    puts "Enter name:"
    name = gets.chomp
  
    match = @address_book.iterative_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end
####################################################################
  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp
 
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end
####################################################################
  def edit_entry(entry)

    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone = gets.chomp
    print "Updated email: "
    email = gets.chomp
 
    entry.name = name if !name.empty?
    entry.phone = phone if !phone.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end
####################################################################
  def delete_entry(entry)
    @address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end
####################################################################
  def detonate
    print "Are you sure you want to delete all entries? (Type DETONATE! to continue): "

    selection = gets.chomp
    
    if selection == "DETONATE!"
      @address_book.entries.delete_if {true}
      puts "All addresses deleted"
      main_menu
    else
      main_menu
    end
  end
####################################################################
  def exit
    system "clear"
    puts "Good-bye!"
    system "exit"
  end

end

