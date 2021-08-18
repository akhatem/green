class ChangeDateInOffersToDateTime < ActiveRecord::Migration[6.1]
  def change
    change_column :offers, :start_at, :datetime
    change_column :offers, :end_at, :datetime
  end
end
