require 'pagy/extras/bootstrap'

Pagy::VARS[:items] = 13
Pagy::VARS[:size] = [1,4,4,1]


require 'pagy/extras/overflow'
Pagy::VARS[:overflow] = :last_page    # default  (other options: :last_page and :exception)

require 'pagy/extras/array'

# require 'pagy/extras/items'
# Pagy::VARS[:items_param] = :items

# require 'pagy/extras/headers'

# Pagy::VARS[:max_items] = 100   
# set to false if you want to make :enable_items_extra an opt-in variable
# Pagy::VARS[:enable_items_extra] = false    # default true