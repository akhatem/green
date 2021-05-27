puts "Create Test Customers started at #{DateTime.now.strftime("%H:%M:%S")}"
if Customer.count.zero?
  Customer.create!(name: "Ahmed Karim", email: "ahmed.karim@gmail.com", 
    password: "password", mobile: "01009051431")

  Customer.create!(name: "Omar Badreldin", email: "omar.badreldin@gmail.com", 
    password: "password", mobile: "01271307341")

  Customer.create!(name: "Yasser AboIbrahim", email: "yasser.aboibrahim@gmail.com", 
    password: "password", mobile: "01100851591")
end
puts "Create Test Customers Finished at #{DateTime.now.strftime("%H:%M:%S")}"