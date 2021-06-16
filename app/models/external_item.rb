class ExternalItem < ActiveRecord::Base

    establish_connection(adapter: "postgresql", database: "greencopy", username: "postgres", password: "asdasd123")
    self.table_name  = "items"
end