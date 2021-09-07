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
    
    has_many :points_movements, dependent: :destroy
    

    validates :customer_id, presence: true
    validates :branch_id, presence: true
    validates :user_id, presence: true
    validates :number, presence: true, uniqueness: { scope: :branch_id }
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
        .where("customers.name ILIKE ?", "%" + search_term + "%")
        .or( where('Receipts.id = ?', search_term.to_i) )
        .joins(:user)
        .includes(:user)
        .or(where("users.name ILIKE ?", "%" + search_term + "%"))
    end
    

    private

    def customer_collect_points
        # earned_points = self.total_price * 0.1
        earned_points = self.total_price *  Setting.find_by(key: :cash_to_points).description.to_f

        PointsMovement.create(customer_id: self.customer_id, branch_id: self.branch_id, 
            earned: earned_points, date_time: DateTime.now, user_id: self.user_id, receipt_id: self.id)
    end
end
