class AddDecodedBarcodeToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :decoded_barcode, :bytea
  end
end
