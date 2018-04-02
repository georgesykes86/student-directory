#Prompts the user to input a name and stores in student array
def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit enter twice"
  #create an empty array
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
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
  names.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#Prints a summary total of students
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end


students = input_students
print_header
print_names(students)
print_footer(students)
