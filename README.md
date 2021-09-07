# About Green Application
# green application with APIs for both Android and IOS mobiles deployed to digitalocean droplet
* APIs for Android and IOS apps. Menu and barcode with points system per customer. 
* Admin page for managing the application which includes  *customers, system users, receipts, points movements, sms messages, system settings, branches, account verification and password reset verification via OTP api*. 

* ` Deploy to DigitalOcean droplet. `
* ` Digitalocean spaces for uploading files. `
* ` Customize the application for production. `

Built this app using the following:
* ` Ruby on Rails `
* ` Javascript `
* ` HTML5 `
* ` CSS `
* ` Bootstrap `

# Gemfile
* ruby '3.0.0'
* gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
* gem 'pg', '~> 1.1'
* gem 'puma', '~> 5.0'
* gem 'sass-rails', '>= 6'
* gem 'webpacker', '~> 5.0'
* gem 'turbolinks', '~> 5'
* gem 'jbuilder', '~> 2.7'
* gem 'redis', '~> 4.0'
* gem 'bcrypt', '~> 3.1.7'
* gem 'image_processing', '~> 1.2'
* gem 'bootsnap', '>= 1.4.4', require: false
* gem 'uglifier'
* gem 'annotate'
* gem 'web-console', '>= 4.1.0'
* gem 'rack-mini-profiler', '~> 2.0'
* gem 'spring'
* ` For Production "Capistrano" `
  * gem 'capistrano', '~> 3.11'
  * gem 'capistrano-rails', '~> 1.4'
  * gem 'capistrano-passenger', '~> 0.2.0'
  * gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'

###### Additional gems
* gem 'barby'
* gem 'rack-cors'
* gem 'chunky_png'
* gem 'devise'
* gem 'pundit'
* gem 'grape'
* gem 'jwt'
* gem 'mini_magick'
* gem 'geocoder'
* gem 'awesome_print'
* gem 'ffaker'
* gem 'sidekiq'
* gem 'sidekiq-cron'
* gem 'sidekiq-scheduler'
* gem 'wicked_pdf'
* gem 'wkhtmltopdf-binary'
* gem 'will_paginate'
* gem 'api-pagination'
* gem 'pagy'
* gem 'carrierwave', '~> 2.0'
* gem "fog-aws"
* gem 'carrierwave-aws'
* gem 'aws-sdk-s3'
* gem 'httpclient'
* gem 'listen'
* gem 'semantic-ui-sass'

### Screenshots from the application uploaded to digitalocean spaces
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_branches_edit.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_branches_show.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_branches.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_brands_edit.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_brands_show.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_brands_starbucks_edit.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_brands.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_categories.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_cities.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_items.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_notifications.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_points_movements.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_receipts.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_settings.png
* https://greenfiles.fra1.digitaloceanspaces.com/uploads/green_sms.png
