class ExternalSize < ActiveRecord::Base

    establish_connection(adapter: "postgresql", database: "greencopy", username: "deploy", password: "root123")
    self.table_name  = "sizes"
end