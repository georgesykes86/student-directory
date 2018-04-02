#Prompts the user to input a name and stores in student array
def input_students
  puts "Please enter the name, age, nationality and cohort of the students in the format:"
  puts "George, 31, British, December"
  puts "To finish just hit enter twice"
  #create an empty array
  students = []
  details = gets.chomp
  while !details.empty? do
    details =~ /^([a-zA-Z ]+),? *(\d*),? *([a-zA-Z ]*),? *([a-zA-Z ]*)/
    $1.empty? ? name = "Anon" : name = $1
    $2.empty? ? age = "unknown" : age = $2
    $3.empty? ? nationality = "unknown" : nationality = $3
    $4.empty? ? cohort = "April" : cohort = $4
    puts "Name: #{name}"
    puts "Age: #{age}"
    puts "Nationality: #{nationality}"
    puts "Cohort: #{cohort}"
    puts "Is this correct? y/n"
    answer = gets.chomp.downcase
    if answer == "y"
      students << { name: name,
                    cohort: cohort.to_sym,
                    age: age,
                    nationality: nationality }
      print "Now we have #{students.count} "
      puts students.count == 1 ? "student" : "students"
    end
    puts "Enter student information"
    details = gets.chomp
  end
  #return the array
  students
end

def print_header
  printer("The students of George's Academy with names shorter than 12 letters")
  printer("--------------------------------------------")
end

#Prints all the names and cohort in order
def print_names(names)
  #Preferred method using each_with_index
  names.select {|name| name[:name].size < 12}.each_with_index do |student, index|
    printer("#{index+1}. #{student[:name]} | Age: #{student[:age]} | "\
            "Nationality: #{student[:nationality]} (#{student[:cohort]} cohort)")
  end
  #Alternative method using until (uncomment code below to use, remember to comment ou code above)
  # students = names.dup
  # index = 0
  # until !student = students.shift do
  #   if student[:name].size < 12
  #     puts "#{index += 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  #   end
  # end
  #Alternative method using while (uncomment code below to use, remember to comment ou code above)
  # index  = 0
  # while index < names.length do
  #   name = names[index]
  #   if name[:name].size < 12
  #     puts "#{index + 1}. #{name[:name]} (#{name[:cohort]} cohort)"
  #   end
  #   index += 1
  # end
end

#Prints a summary total of students
def print_footer(names)
  names.count == 1 ? noun = "student" : noun = "students"
  printer("Overall, we have #{names.count} great #{noun}")
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

def printer(string)
  puts string.center(80)
end

students = input_students
names_by_first_initial(students)
