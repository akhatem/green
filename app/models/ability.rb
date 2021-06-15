class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    
    if user &.role.key.eql?("admin")
      user.role.permissions.each do |permission|
        if defined? permission.class_name.constantize.to_s
          if Object.const_defined?(permission.class_name.constantize.to_s)
            can permission.action.to_sym, permission.class_name.constantize
          end
        end
      end
    end
      cannot [:destroy], User, id: user.id
      cannot [:destroy], Role, id: user.role.id
  end
end
