json.customer do |json|
    json.partial! 'customers/customer', customer: current_customer
end