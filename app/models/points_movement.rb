# == Schema Information
#
# Table name: points_movements
#
#  id             :bigint           not null, primary key
#  customer_id    :bigint           not null
#  branch_id      :bigint           not null
#  user_id        :integer
#  redeemed       :integer          default(0)
#  earned         :integer          default(0)
#  date_time      :datetime         not null
#  total          :integer          default(0)
#  current_points :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class PointsMovement < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  belongs_to :branch

  validates :total, numericality: { greater_than_or_equal: 0 }
  
  # before_create :update_earned_points
  before_create :calculate_current_points
  after_create :update_total, :update_customer_points
  # after_create :redeemed_points_check

  def customerName
    Customer.find(self.customer_id).name
  end

  def userName
      User.find(self.user_id).name       
  end

  def branchName
      Branch.find(self.branch_id).name
  end

  def convert_points_to_cash
    # self.total * 0.5
    self.total * Setting.find_by(key: :points_to_cash)
  end

  private
  
  def calculate_current_points
    self.write_attribute(:current_points, (self.earned - self.redeemed))
  end

  def update_total
    pm_total = PointsMovement.where(customer_id: self.customer_id).last(2).first.total
    sum_of_points = pm_total + self.current_points
    # puts "========> sum of points: #{sum_of_points}"
    self.update(total: sum_of_points)
  end

  # def price_to_points
  #   receipt_total_price = Receipt.where(customer_id: self.customer_id).last(2).first.total_price
  #   receipt_total_price * 0.1
  # end
  
  # def update_earned_points
  #   puts "======> price_to points: #{price_to_points}"
  #   self.write_attribute(:earned, price_to_points)
  # end

  # def redeemed_points_check
  #   if self.redeemed > self.total
  #     self.errors.add(:redeemed, "Must be less than total!")
  #     PointsMovement.last.destroy
  #   end
  # end

  def update_customer_points
    # puts "Customer id in PM: #{self.customer_id}"
    customer = Customer.find(self.customer_id)
    customer.update(points: self.total)
    puts customer.update(points: self.total)
  end
end
