# == Schema Information
#
# Table name: receipts
#
#  id          :bigint           not null, primary key
#  customer_id :bigint           not null
#  branch_id   :bigint           not null
#  user_id     :bigint           not null
#  number      :string           not null
#  total_price :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Receipt < ApplicationRecord
    belongs_to :customer
    belongs_to :user
    belongs_to :branch
    

    validates :customer_id, presence: true
    validates :branch_id, presence: true
    validates :user_id, presence: true
    validates :number, presence: true
    validates :total_price, presence: true

    after_create :customer_collect_points

    private

    def customer_collect_points
        earned_points = self.total_price * 0.1
        PointsMovement.create(customer_id: self.customer_id, branch_id: self.branch_id, 
            earned: earned_points, date_time: DateTime.now)
    end
end
