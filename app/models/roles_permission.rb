class RolesPermission < ApplicationRecord

    belongs_to :role
    belongs_to :permission

    validates_uniqueness_of :role_id, scope: :permission_id
end
