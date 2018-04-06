@students = []

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list of students to students.csv"
  puts "4. Load the list from students.csv"
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
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end


def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, age, nationality, cohort = line.chomp.split(",")
    @students << { name: name, age: age, nationality: nationality, cohort: cohort.to_sym }
  end
  file.close
end

#Prompts the user to input a name and stores in student array
def input_students
  print_input_instructions
  while (details = STDIN.gets.strip) && !details.empty? do
    student = parse_input_data(details)
    print_user_input(student)
    add_student(student) if STDIN.gets.strip.downcase == "y"
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

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:age], student[:nationality], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
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
  input = STDIN.gets.chomp
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
