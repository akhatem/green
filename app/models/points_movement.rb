# == Schema Information
#
# Table name: points_movements
#
#  id             :bigint           not null, primary key
#  customer_id    :bigint           not null
#  branch_id      :bigint           not null
#  redeemed       :integer          default(0)
#  earned         :integer          default(0)
#  date_time      :datetime         not null
#  total          :integer          default(0)
#  current_points :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  receipt_id     :bigint
#
class PointsMovement < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  belongs_to :branch
  belongs_to :receipt

  validates :total, numericality: { greater_than_or_equal: 0 }
  
  before_create :calculate_current_points
  after_create :update_total, :update_customer_points

  def customerName
    Customer.find(self.customer_id).name
  end

  def userName
      User.find(self.user_id).name       
  end

  def branchName
      Branch.find(self.branch_id).name
  end

  def receiptNumber
    Receipt.find(self.receipt_id).number
  end

  def convert_points_to_cash
    self.total * Setting.find_by(key: :points_to_cash).description.to_f
  end

  def self.search_by(search_term)
    where(id: search_term.to_i)
    .or(where("receipt_id = ?", Receipt.find_by(id: search_term.to_i)))
    .or(where(date_time: "%" + search_term + "%"))
  end

  private
  
  def calculate_current_points
    self.write_attribute(:current_points, (self.earned - self.redeemed))
  end

  def update_total
    pm_total = PointsMovement.where(customer_id: self.customer_id).last(2).first.total
    sum_of_points = pm_total + self.current_points
    self.update(total: sum_of_points)
  end

  
  def update_customer_points
    customer = Customer.find(self.customer_id)
    customer.update(points: self.total)
  end

end
