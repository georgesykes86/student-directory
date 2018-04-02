#First we will print out the list of students
students = [
  "Dr. Hannibal Lecter",
  "Darth Vadar",
  "Nurse Ratchet",
  "Michael Corleone",
  "Alex Delarge",
  "The Wicked WItch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

def print_header
  puts"The students of Villain's Academy"
  puts "-------------------"
end

def print_names(names)
  names.each do |student|
    puts student
  end
end

#Adding a summary total of students
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

print_header
print_names(students)
print_footer(students)
