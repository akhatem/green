class RemoveTypeFromOffers < ActiveRecord::Migration[6.1]
  def change
    remove_column :offers, :is_default, :boolean
  end
end
