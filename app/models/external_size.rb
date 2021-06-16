class ExternalSize < ActiveRecord::Base

    establish_connection(adapter: "postgresql", database: "greencopy", username: "postgres", password: "asdasd123")
    self.table_name  = "sizes"
end