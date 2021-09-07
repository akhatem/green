if Rails.env.development?
  if Customer.count.zero?
    puts "Create Test Customers started at #{DateTime.now.strftime("%H:%M:%S")}"
    Customer.find_or_create_by(name: "Ahmed Kareem", email: "ahmed.kareem.elshawadfy@gmail.com", 
      password: "Pass_123!", mobile: "01009051431")

    Customer.find_or_create_by(name: "Omar Badreldin", email: "omar.badreldin@gmail.com", 
      password: "password", mobile: "01271307341")

    Customer.find_or_create_by(name: "Yasser AboIbrahim", email: "yasser.aboibrahim@gmail.com", 
      password: "password", mobile: "01100851591")

      
    puts "Create Test Customers Finished at #{DateTime.now.strftime("%H:%M:%S")}"
  end


  if City.count.zero?
    puts "Create Cities started #{DateTime.now.strftime("%H:%M:%S")}"
    City.find_or_create_by(name: "Alexandria")
    City.find_or_create_by(name: "Cairo")
    City.find_or_create_by(name: "Portsaid")
    City.find_or_create_by(name: "Dahab")
    puts "Create Cities finished #{DateTime.now.strftime("%H:%M:%S")}"
  end

  if Branch.count.zero?
    puts "Create Branches started #{DateTime.now.strftime("%H:%M:%S")}"
    Branch.create(name: "Green Cafe", link: "https://www.google.com/maps/place/Starbucks+Coffee/@31.214832,29.9506971,16.5z/data=!4m8!1m2!2m1!1sPolo+court,+Smouha+Club,+Alexandria!3m4!1s0x14f5c58c234b59e3:0xb72d5a52e33276d6!8m2!3d31.2148738!4d29.9531291", 
      long: 31.215052632337116, lat: 29.953079249525377, address: "Polo court, Smouha Club, Alexandria", city_id: 1)

    Branch.create(name: "Starbucks cafe", link: "https://www.google.com/maps/place/Platz/@30.0219911,31.4423278,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x522c5ba75e6b7468!8m2!3d30.0219979!4d31.4445239", 
      long: 30.02233223689489, lat: 31.44672603423963, address: "Platz, New Cairo City, Cairo Governorate", city_id: 2)
    puts "Create Branches finished #{DateTime.now.strftime("%H:%M:%S")}"
  end

  if Brand.count.zero?
    puts "Create Brands started at #{DateTime.now.strftime("%H:%M:%S")}"
    Brand.create(id: 1, name: "Green", image: File.open(File.join(Rails.root, 'app/assets/images/brands/green_logo.png')))
    
    Brand.create(id: 2, name: "Starbucks", image: File.open(File.join(Rails.root, 'app/assets/images/brands/starbucks_logo.png')))
    puts "Create Brands finished at #{DateTime.now.strftime("%H:%M:%S")}"
  end

  Brand.all.each do |brand|
    # unless Category.exists?(brand_id: brand.id)
    if Category.count.zero?
      puts "Create Categories started at #{DateTime.now.strftime("%H:%M:%S")}"
        for  i in 1..5 do
          category = Category.find_or_create_by(name: FFaker::Food::unique.fruit, brand_id: brand.id)
          
          if Item.count.zero?
            puts "Create Items started at #{DateTime.now.strftime("%H:%M:%S")}"
            5.times do
              Item.create(name: FFaker::Food::meat, description: FFaker::Food::ingredient, brand_id: brand.id, 
                category_id: category.id, image: File.open(File.join(Rails.root, 'app/assets/images/items/placeholder.png')))
                sleep(2)
            end
            puts "Create Items finished #{DateTime.now.strftime("%H:%M:%S")}"
          end
        end
      puts "Create Categories finished #{DateTime.now.strftime("%H:%M:%S")}"
    end
  end

  if Size.count.zero?
    puts "Create Sizes started #{DateTime.now.strftime("%H:%M:%S")}"
    Size.find_or_create_by(id: 1, name: "Regular")
    Size.find_or_create_by(id: 2, name: "Grande")
    Size.find_or_create_by(id: 3, name: "Tall")
    puts "Create Sizes finished #{DateTime.now.strftime("%H:%M:%S")}"
  end

  if ItemSize.count.zero?
    puts "Create ItemSizes started #{DateTime.now.strftime("%H:%M:%S")}"

    puts "Create Items started #{DateTime.now.strftime("%H:%M:%S")}"
    Item.all.each do |item|
      Size.all.each do |size|
        ItemSize.find_or_create_by(item_id: item.id, size_id: size.id, price: rand(15..200))
      end
    end
    puts "Create ItemSizes finished #{DateTime.now.strftime("%H:%M:%S")}"
  end

  # if PointsMovement.count.zero?
    # puts "Create PointsMovements started #{DateTime.now.strftime("%H:%M:%S")}"
      PointsMovement.create(customer_id: 43, branch_id: 1, earned: 150, date_time: DateTime.now, user_id: 1)
      PointsMovement.create(customer_id: 43, branch_id: 2, redeemed: 100, date_time: DateTime.now, user_id: 1)
      
      PointsMovement.create(customer_id: 23, branch_id: 1, earned: 150, date_time: DateTime.now, user_id: 1)
      PointsMovement.create(customer_id: 23, branch_id: 2, redeemed: 100, date_time: DateTime.now, user_id: 1)

      PointsMovement.create(customer_id: 19, branch_id: 1, earned: 150, date_time: DateTime.now, user_id: 1)
      PointsMovement.create(customer_id: 19, branch_id: 2, redeemed: 50, date_time: DateTime.now, user_id: 1)
      
  #     PointsMovement.create(customer_id: 2, branch_id: 2, earned: 500, date_time: DateTime.now)
  #     PointsMovement.create(customer_id: 2, branch_id: 2, redeemed: 200, date_time: DateTime.now)

  #     PointsMovement.create(customer_id: 3, branch_id: 2, earned: 200, redeemed: 100, date_time: DateTime.now)
  #   puts "Create PointsMovements finished #{DateTime.now.strftime("%H:%M:%S")}"
  # end

  if Setting.count.zero?
    puts "Create Settings started #{DateTime.now.strftime("%H:%M:%S")}"
    
    Setting.find_or_create_by(id: 1, name: "About Us", description: "Welcome to Green App. This app is all about Green Cafe")
    Setting.find_or_create_by(id: 2, name: "Contact Us", description: "+201014911173")
    Setting.find_or_create_by(id: 3, name: "Cash to points", description: "0.1")
    Setting.find_or_create_by(id: 4, name: "Points to cash", description: "0.5")
  end
  puts "Create Settings finished #{DateTime.now.strftime("%H:%M:%S")}"

  if Offer.count.zero?
    puts "Create Offers started #{DateTime.now.strftime("%H:%M:%S")}"
    for i in 1..3 do
      Offer.create(title: FFaker::Lorem::words, description: FFaker::Lorem::sentences, state: 1, 
      start_at: Date.today, end_at: Date.today+1.day, image: File.open(File.join(Rails.root, 'app/assets/images/offers/offer1.png')))
      sleep(2)
    end

    for i in 1..3 do
      Offer.create(title: FFaker::Lorem::words, description: FFaker::Lorem::sentences, state: 0, 
      start_at: 3.days.ago, end_at: Date.yesterday, image: File.open(File.join(Rails.root, 'app/assets/images/offers/offer1.png')))
      sleep(2)
    end
    puts "Create Offers finished #{DateTime.now.strftime("%H:%M:%S")}"
  end


  Role.create!(id: 1, name: "Super", key: "super", description: "Full access", is_super: true)
  Role.create!(id: 2, name: "Admin", key: "admin", description: "Only admin pages", is_super: false)
  Role.create!(id: 3, name: "Cashier", key: "cashier", description: "Only Cashier specified pages", is_super: false)
  
  User.create!(name: "Ahmed Kareem", email: "ahmed.kareem.elshawadfy@gmail.com", password: "Root123",
    password_confirmation: "Root123", role_id: 1)
  
  User.create(name: "Hatem Mohamed", email: "hatem.mohamed@green.com", password: "Hatem123", 
    password_confirmation: "Hatem123", role_id: 2, branch_id: 1)

  User.create(name: "Omar Ali", email: "omar.ali@green.com", password: "Omar123", 
    password_confirmation: "Omar123", role_id: 3, branch_id: 1)

  
end


if Rails.env.production?

  # ExternalBrand.all.each do |eb|
  #   ActiveRecord::Base.establish_connection(:production)
  #   Brand.create(eb.attributes)
  # end

  # ExternalCategory.all.each do |ec|
  #   ActiveRecord::Base.establish_connection(:production)
  #   Category.create(ec.attributes)
  # end 

  # ExternalItem.all.each do |ei|
  #   ActiveRecord::Base.establish_connection(:production)
  #   Item.create(ei.attributes)
  # end

  # ExternalSize.all.each do |ez|
  #   ActiveRecord::Base.establish_connection(:production)
  #   Size.create(ez.attributes)
  # end

  # ExternalItemSize.all.each do |eis|
  #   ActiveRecord::Base.establish_connection(:production)
  #   ItemSize.create(eis.attributes)
  # end

  Role.create!(id: 1, name: "Super", key: "super", description: "Full access", is_super: true)

  User.create!(name: "Yara Samy", email: "yara.samy@green.com", password: "yara12345",
    password_confirmation: "yara12345", role_id: 1)
  
  User.create!(name: "Ahmed Kareem", email: "ahmed.kareem@green.com", password: "Kareem",
      password_confirmation: "Kareem", role_id: 1)
  
  # User.create!(name: "Yasser Fayez", email: "yasser.fayez@green.com", password: "4455662@roV",
  #       password_confirmation: "4455662@roV", role_id: 1, branch_id: 1)



  Setting.find_or_create_by(id: 1, name: "About Us", description: "Welcome to Green App. This app is all about Green Cafe")
  Setting.find_or_create_by(id: 2, name: "Contact Us", description: "01014911173")
  Setting.find_or_create_by(id: 3, name: "Redeem Equation", description: "total_price * 0.1")

    # User.create!(name: "Yasser Fayez", email: "yasser.fayez.aboibrahim@gmail.com", password: "4455662@roD",
    #   password_confirmation: "4455662@roD", role_id: 1, branch_id: 1)


  # item_image_url = Item.find(11).image_url

  # Item.all.where(category_id: 8).each do |item|
  #   item.update(remote_image_url: item_image_url)
  # end
end


# Customer.reset_counters Customer.all.length - 1
# Offer.reset_counters Offer.all.length


# ActiveRecord::Base.connection.tables.each do |t|
#   ActiveRecord::Base.connection.reset_pk_sequence!(t)
# end


  # classes = [ActiveRecord::Base.connection.tables.map{ |model| model.capitalize.singularize.camelize }, :tables_list]

  # permissions = {}

  # classes.each do |clazz|
  #   policy =  Pundit.policy(User.last, :Branch)
  #   policy.public_methods(false).sort.each do |m|
  #     result = policy.send m
  #     permissions["#{clazz}.#{m}"] = result
  #   end
  # end

  # permissions


  # ActiveRecord::Base.connection.tables.map{ |model| model.capitalize.singularize.camelize }

  # Brand.all.each do |brand|
  #   for  i in 1..5 do
  #     category = Category.find_or_create_by(name: FFaker::Food::unique.fruit, brand_id: brand.id)
  #     5.times do
  #       Item.create(name: FFaker::Food::meat, description: FFaker::Food::ingredient, brand_id: brand.id, 
  #         category_id: category.id, image: File.open(File.join(Rails.root, 'app/assets/images/items/placeholder.png')))
  #     end
  #   end
  # end












