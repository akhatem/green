# == Schema Information
#
# Table name: points_movements
#
#  id             :bigint           not null, primary key
#  current_points :integer          default(0)
#  date_time      :datetime         not null
#  earned         :integer          default(0)
#  redeemed       :integer          default(0)
#  total          :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  branch_id      :bigint           not null
#  customer_id    :bigint           not null
#
# Indexes
#
#  index_points_movements_on_branch_id    (branch_id)
#  index_points_movements_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (customer_id => customers.id)
#
class PointsMovement < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :branch

  validates :total, numericality: { greater_than_or_equal: 0 }
  
  # validate :redeemed_points
  
  before_create :calculate_current_points
  after_create :update_total, :update_customer_points


  private

  # def redeemed_points
  #   if self.redeemed > self.total
  #     self.errors.add(:redeemed, "Must be less than total!")
  #   end
  # end
  
  def update_total
    # total_current_points = PointsMovement.where(customer_id: self.customer_id).pluck(:current_points).sum
    pm = PointsMovement.where(customer_id: self.customer_id).last(2).first
    sum_of_points = pm.total + self.current_points
    self.update(total: sum_of_points)
  end

  def calculate_current_points
    self.write_attribute(:current_points, (self.earned - self.redeemed))
  end

  def update_customer_points
    customer = Customer.find(customer_id)
    customer.update(points: total)
  end
end
