if Rails.env.development?
  # if Customer.count.zero?
  #   puts "Create Test Customers started at #{DateTime.now.strftime("%H:%M:%S")}"
    # Customer.find_or_create_by(name: "Ahmed Karim", email: "ahmed.karim@gmail.com", 
    #   password: "password", mobile: "01009051431")

  #   Customer.find_or_create_by(name: "Omar Badreldin", email: "omar.badreldin@gmail.com", 
  #     password: "password", mobile: "01271307341")

  #   Customer.find_or_create_by(name: "Yasser AboIbrahim", email: "yasser.aboibrahim@gmail.com", 
  #     password: "password", mobile: "01100851591")
  # end
  # puts "Create Test Customers Finished at #{DateTime.now.strftime("%H:%M:%S")}"


  if City.count.zero?
    puts "Create Cities started #{DateTime.now.strftime("%H:%M:%S")}"
    City.find_or_create_by(name: "Alexandria")
    City.find_or_create_by(name: "Cairo")
    City.find_or_create_by(name: "Portsaid")
    City.find_or_create_by(name: "Dahab")
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

  # if Brand.count.zero?
  #   puts "Create Brands started at #{DateTime.now.strftime("%H:%M:%S")}"
  #   Brand.create(id: 1, name: "Green", image: File.open(File.join(Rails.root, 'app/assets/images/brands/green_logo.png')))
    
  #   Brand.create(id: 2, name: "Starbucks", image: File.open(File.join(Rails.root, 'app/assets/images/brands/starbucks_logo.png')))
  # end
  # puts "Create Brands finished at #{DateTime.now.strftime("%H:%M:%S")}"

  Brand.all.each do |brand|
    unless Category.exists?(brand_id: brand.id)
      puts "Create Categories started at #{DateTime.now.strftime("%H:%M:%S")}"
      for  i in 1..5 do
        category = Category.find_or_create_by(name: FFaker::Food::unique.fruit, brand_id: brand.id)
        
        
        puts "Create Items started at #{DateTime.now.strftime("%H:%M:%S")}"
        for j in (1..30).to_a.shuffle do
          Item.create(name: FFaker::Food::meat, 
          description: FFaker::Food::ingredient, brand_id: brand.id, 
          category_id: category.id, image: File.open(File.join(Rails.root, 'app/assets/images/items/placeholder.png')))
        end

        for j in (31..60).to_a.shuffle do
          Item.create(name: FFaker::Food::meat, 
          description: FFaker::Food::ingredient, brand_id: brand.id, 
          category_id: category.id, image: File.open(File.join(Rails.root, 'app/assets/images/items/placeholder.png')))
        end
        puts "Create Items finished #{DateTime.now.strftime("%H:%M:%S")}"
      end
      puts "Create Categories finished #{DateTime.now.strftime("%H:%M:%S")}"
    end
  end

  if Size.count.zero?
    puts "Create Sizes started #{DateTime.now.strftime("%H:%M:%S")}"
    Size.find_or_create_by(id: 1, name: "Regular", price: 50)
    Size.find_or_create_by(id: 2, name: "Grande", price: 45)
    Size.find_or_create_by(id: 3, name: "Tall", price: 35)
  end
  puts "Create Sizes finished #{DateTime.now.strftime("%H:%M:%S")}"

  if ItemSize.count.zero?
    puts "Create ItemSizes started #{DateTime.now.strftime("%H:%M:%S")}"

    puts "Create Items started #{DateTime.now.strftime("%H:%M:%S")}"
    Item.all.each do |item|
      Size.all.each do |size|
        ItemSize.find_or_create_by(item_id: item.id, size_id: size.id)
      end
    end
    puts "Create Items finished #{DateTime.now.strftime("%H:%M:%S")}"
  end
  puts "Create ItemSizes finished #{DateTime.now.strftime("%H:%M:%S")}"

  # if PointsMovement.count.zero?
  #   puts "Create PointsMovements started #{DateTime.now.strftime("%H:%M:%S")}"
  #     PointsMovement.create(customer_id: 1, branch_id: 1, earned: 100, date_time: DateTime.now)
  #     PointsMovement.create(customer_id: 1, branch_id: 2, redeemed: 50, date_time: DateTime.now)
      
  #     PointsMovement.create(customer_id: 2, branch_id: 2, earned: 500, date_time: DateTime.now)
  #     PointsMovement.create(customer_id: 2, branch_id: 2, redeemed: 200, date_time: DateTime.now)

  #     PointsMovement.create(customer_id: 3, branch_id: 2, earned: 200, redeemed: 100, date_time: DateTime.now)
  #   puts "Create PointsMovements finished #{DateTime.now.strftime("%H:%M:%S")}"
  # end

  if Setting.count.zero?
    puts "Create Settings started #{DateTime.now.strftime("%H:%M:%S")}"
    
    Setting.find_or_create_by(id: 1, name: "About Us", description: 'Where does it come from?
  Contrary to popular belief, Lorem Ipsum is not simply random text. 
  It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.
  Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, 
  looked up one of the more obscure Latin words, consectetur, 
  from a Lorem Ipsum passage, and going through the cites of the word in classical literature, 
  discovered the undoubtable source.')
    Setting.find_or_create_by(id: 2, name: "Contact Us", description: "+201010101010")
  end
  puts "Create Settings finished #{DateTime.now.strftime("%H:%M:%S")}"

  if Offer.count.zero?
    puts "Create Offers started #{DateTime.now.strftime("%H:%M:%S")}"
    for i in 1..5 do
      Offer.create(title: FFaker::Lorem::words, description: FFaker::Lorem::sentences, state: 1, 
      start_at: Date.today, end_at: Date.today+1.day, image: File.open(File.join(Rails.root, 'app/assets/images/offers/offer1.png')))
    end

    for i in 1..15 do
      Offer.create(title: FFaker::Lorem::words, description: FFaker::Lorem::sentences, state: 0, 
      start_at: 3.days.ago, end_at: Date.yesterday, image: File.open(File.join(Rails.root, 'app/assets/images/offers/offer1.png')))
    end
  end
  puts "Create Offers finished #{DateTime.now.strftime("%H:%M:%S")}"

end

if Rails.env.production?
  Role.find_or_create_by(id: 1, name: "Super", key: "super", description: "Full access", is_super: true)
  User.find_or_create_by(email: "ahmed.kareem.elshawadfy@gmail.com", password: "Root123", password_confirmation: "Root123", role_id: 1)
end


# green = ActiveRecord::Base.establish_connection(:production)
# greencopy = ActiveRecord::Base.establish_connection(adapter: "postgresql", database: "greencopy", username: "postgres", password: "asdasd123")
# items = greencopy.connection.execute("select * from items")

# class Item < ActiveRecord
#   Item.update_all()

#   end
# end

# items.each do |i|
#   Item.create(:name => p.name.downcase) #NewPost should add Post in A. (mynewapp_psql)
# end