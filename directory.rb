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

puts"The students of Villain's Academy"
puts "-------------------"
students.each do |student|
  puts student
end
#Adding a summary total of students
puts "Overall, we have #{students.count} great students"
