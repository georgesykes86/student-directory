@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

#Prompts the user to input a name and stores in student array
def input_students
  print_input_instructions
  while (details = gets.strip) && !details.empty? do
    student = parse_input_data(details)
    print_user_input(student)
    if gets.strip.downcase == "y"
      add_student(student)
    end
    puts "Enter student information"
  end
end

def print_input_instructions
  puts "Please enter the name, age, nationality and cohort of the students in the format:"
  puts "George, 31, British, December"
  puts "To finish just hit enter twice"
end

def parse_input_data(person_input)
  input_details = {}
  person_input =~ /^([a-zA-Z ]+),? *(\d*),? *([a-zA-Z ]*),? *([a-zA-Z ]*)/
  $1.empty? ? input_details[:name] = "Anon" : input_details[:name] = $1
  $2.empty? ? input_details[:age] = "unknown" : input_details[:age] = $2
  $3.empty? ? input_details[:nationality] = "unknown" : input_details[:nationality] = $3
  $4.empty? ? input_details[:cohort] = "April" : input_details[:cohort] = $4.downcase.capitalize
  input_details
end

def print_user_input(person_info)
  puts "Name: #{person_info[:name]}"
  puts "Age: #{person_info[:age]}"
  puts "Nationality: #{person_info[:nationality]}"
  puts "Cohort: #{person_info[:cohort]}"
  puts "Is this correct? y/n"
end

def add_student(student)
  @students << { name: student[:name],
                cohort: student[:cohort].to_sym,
                age: student[:age],
                nationality: student[:nationality] }
  print "Now we have #{@students.count} "
  puts @students.count == 1 ? "student" : "students"
end

def print_header
  printer("The students of George's Academy with names shorter than 12 letters")
  printer("--------------------------------------------")
end

#Prints all the names and cohort in order
def print_students_list
  if !@students.empty?
    index = 0
    @students.map {|student| student[:cohort]}.uniq.each do |month|
      @students.select {|name| name[:name].size < 12 && name[:cohort] == month}
      .each do |student|
              printer("#{index += 1}. #{student[:name]} | Age: #{student[:age]} | "\
                      "Nationality: #{student[:nationality]} (#{student[:cohort]} cohort)")
      end
    end
  else
    printer "There are no students in the academy"
  end
end

#Prints a summary total of students
def print_footer
  @students.count == 1 ? noun = "student" : noun = "students"
  printer("Overall, we have #{@students.count} great #{noun}") if !@students.empty?
end

def print_names_by_first_initial
  print_search_instructions
  input = gets.chomp
  print_header
  if !input.empty?
    print_names(@students.select {|name| name[:name].chr.downcase == input.downcase})
  else
    print_students_list
  end
  print_footer
end

def print_search_instructions
  puts "Please enter a first name initial to search by"
  puts "Press enter twice to print all names"
end

def printer(string)
  puts string.center(80)
end

interactive_menu
