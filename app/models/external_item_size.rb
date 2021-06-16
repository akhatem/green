class ExternalItemSize < ActiveRecord::Base

    establish_connection(adapter: "postgresql", database: "greencopy", username: "postgres", password: "asdasd123")
self.table_name  = "item_sizes"
end