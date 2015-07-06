def greeting
  
  ARGV.each do |arg|
    puts ARGV[0] + ", #{arg}!" unless arg == ARGV[0]
  end

end 
 
greeting