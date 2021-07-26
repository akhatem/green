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
    validates :number, presence: true, uniqueness: true
    validates :total_price, presence: true

    after_create :customer_collect_points

    def customerName
        Customer.find(self.customer_id).name
    end

    def userName
        User.find(self.user_id).name       
    end

    def branchName
        Branch.find(self.branch_id).name
    end
    
    def self.search_by(search_term)
        joins(:customer)
        .includes(:customer)
        .where("LOWER(customers.name) LIKE ?", "%" + search_term.downcase + "%")
        .or( where('Receipts.id = ?', search_term.to_i) )
        .joins(:user)
        .includes(:user)
        .or(where("LOWER(users.name) LIKE ?", "%" + search_term.downcase + "%"))
    end
    

    private

    def customer_collect_points
        earned_points = self.total_price * 0.1
        # puts "================> In receipt model: earned_points: #{earned_points}"

        PointsMovement.create(customer_id: self.customer_id, branch_id: self.branch_id, 
            earned: earned_points, date_time: DateTime.now, user_id: self.user_id)
    end
end
