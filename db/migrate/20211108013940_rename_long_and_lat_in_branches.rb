class RenameLongAndLatInBranches < ActiveRecord::Migration[6.1]
  def change
    rename_column :branches, :long, :longitude
    rename_column :branches, :lat, :latitude
  end
end
