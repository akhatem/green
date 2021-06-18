# == Schema Information
#
# Table name: roles_permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint           not null
#  permission_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class RolesPermission < ApplicationRecord

    belongs_to :role
    belongs_to :permission

    validates_uniqueness_of :role_id, scope: :permission_id
end
