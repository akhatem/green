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

if City.count.zero?
  puts "Create Cities started #{DateTime.now.strftime("%H:%M:%S")}"
  City.create!(name: "Alexandria")
  City.create!(name: "Cairo")
  City.create!(name: "Portsaid")
  City.create!(name: "Dahab")
end
puts "Create Cities finished #{DateTime.now.strftime("%H:%M:%S")}"


if Branch.count.zero?
  puts "Create Branches started #{DateTime.now.strftime("%H:%M:%S")}"
  Branch.create(name: "Green Cafe", link: "https://www.google.com/maps/place/Starbucks+Coffee/@31.214832,29.9506971,16.5z/data=!4m8!1m2!2m1!1sPolo+court,+Smouha+Club,+Alexandria!3m4!1s0x14f5c58c234b59e3:0xb72d5a52e33276d6!8m2!3d31.2148738!4d29.9531291", 
    long: 31.215052632337116, lat: 29.953079249525377, address: "Polo court, Smouha Club, Alexandria", city_id: 1)

  Branch.create(name: "Starbucks cafe", link: "https://www.google.com/maps/place/Platz/@30.0219911,31.4423278,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x522c5ba75e6b7468!8m2!3d30.0219979!4d31.4445239", 
    long: 30.02233223689489, lat: 31.44672603423963, address: "Platz, New Cairo City, Cairo Governorate", city_id: 2)
end
puts "Create Branches finished #{DateTime.now.strftime("%H:%M:%S")}"