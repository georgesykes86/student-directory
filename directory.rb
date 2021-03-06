require 'csv'

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
  puts "3. Save the list of students to file"
  puts "4. Load the list from file"
  puts "5. Search students by first initial"
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
    file = get_filename
    save_students(file)
  when "4"
    file = get_filename
    load_students(file)
  when "5"
    print_names_by_first_initial
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    puts "Loading from students.csv"
    load_students
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist. Loading from students.csv"
    load_students
  end
end


def load_students(filename = "students.csv")
  if File.exists?(filename)
    CSV.foreach(filename) do |line|
      add_student(line) if !line.empty?
    end
    print_summary
  else
    puts "File #{filename} does not exist"
  end
end

#Prompts the user to input a name and stores in student array
def input_students
  print_input_instructions
  while (details = STDIN.gets.strip) && !details.empty? do
    student = parse_input_data(details)
    if !student.empty?
      print_user_input(student)
      if STDIN.gets.strip.downcase == "y"
        add_student(student)
        print_summary
      end
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
  input_details = []
  begin
    person_input =~ /^([a-zA-Z ]+),? *(\d*),? *([a-zA-Z ]*),? *([a-zA-Z ]*)/
    $1.empty? ? input_details << "Anon" : input_details << $1
    $2.empty? ? input_details << "unknown" : input_details << $2
    $3.empty? ? input_details << "unknown" : input_details << $3
    $4.empty? ? input_details << "April" : input_details << $4.downcase.capitalize
  rescue Exception => e
    puts "Input data not it the correct format"
    return input_details
  else
    input_details
  end
end

def print_user_input(person_info)
  puts "Name: #{person_info[0]}"
  puts "Age: #{person_info[1]}"
  puts "Nationality: #{person_info[2]}"
  puts "Cohort: #{person_info[3]}"
  puts "Is this correct? y/n"
end

def add_student(student)
  @students << { name: student[0],
                cohort: student[3].to_sym,
                age: student[1],
                nationality: student[2] }
end

def save_students(filename = "students.csv")
  CSV.open(filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:age], student[:nationality], student[:cohort]]
    end
  end
  puts "Students have been saved"
end

def print_header
  printer("The students of George's Academy with names shorter than 12 letters")
  printer("--------------------------------------------")
end

#Prints all the names and cohort in order
def print_students_list(students = @students)
  if !students.empty?
    index = 0
    students.map {|student| student[:cohort]}.uniq.each do |month|
      students.select {|name| name[:name].size < 12 && name[:cohort] == month}
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
    print_students_list(@students.select {|name| name[:name].chr.downcase == input.downcase})
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

def print_summary
  print "Now we have #{@students.count} "
  puts @students.count == 1 ? "student" : "students"
end

def get_filename
  puts "Please enter a filename"
  file = gets.chomp
end

interactive_menu
