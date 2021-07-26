class CreateOfferCaroselImages < ActiveRecord::Migration[6.1]
  def change
    create_table :offer_carosel_images do |t|
      t.string :image, comment: "Offer Carosel Image"

      t.timestamps
    end
  end
end
