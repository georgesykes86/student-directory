#First we will print out the list of students
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vadar", cohort: :november},
  {name: "Nurse Ratchet", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex Delarge", cohort: :november},
  {name: "The Wicked WItch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

def print_header
  puts"The students of Villain's Academy"
  puts "-------------------"
end

def print_names(names)
  names.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#Adding a summary total of students
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

print_header
print_names(students)
print_footer(students)
