class StaticPagesControllerPolicy
    attr_reader :user, :ctrl
    
    def initialize(user, ctrl)
        @user = user
        @ctrl = ctrl
    end
    
    def index?
        !user.roleKey.eql?("cashier")
    end
end