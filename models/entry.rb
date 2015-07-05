class Entry
   attr_accessor :name, :phone, :email

   def initialize(name, phone, email)
     @name = name
     @phone = phone
     @email = email
   end

   def to_s
     "Name: #{@name}\nPhone Number: #{@phone}\nEmail: #{@email}"
   end

end
