#Prompts the user to input a name and stores in student array
def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit enter twice"
  #create an empty array
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    print "Now we have #{students.count} "
    puts students.count == 1 ? "student" : "students"
    name = gets.chomp
  end
  #return the array
  students
end

def print_header
  puts"The students of George's Academy"
  puts "-------------------"
end

#Prints all the names and cohort in order
def print_names(names)
  names.select {|name| name[:name].size < 12}.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#Prints a summary total of students
def print_footer(names)
  print "Overall, we have #{names.count} great "
  puts names.count == 1 ? "student" : "students"
end

def names_by_first_initial(names)
  puts "Please enter a first name initial to search by"
  puts "Press enter twice to print all names"
  puts "Type exit to leave program"
  input = gets.chomp
  while input != "exit" do
    print_header
    if !input.empty?
      print_names(names.select {|name| name[:name].chr.downcase == input.downcase})
    else
      print_names(names)
    end
    print_footer(names)
    input = gets.chomp
  end
end


students = input_students
names_by_first_initial(students)
