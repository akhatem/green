class AddTypeToOffers < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :is_default, :boolean, default: false
  end
end
