json.(customer, :id, :email, :name, :mobile, :barcode)
json.token customer.generate_jwt
json.barcode customer.generate_barcode