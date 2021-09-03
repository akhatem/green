# class PoliciesController < ApplicationController
#     def index
#         classes = [User, Branch, Role, :user_definition]     
    
#         permissions = { }                             
    
#         classes.each do |clazz|                       
#             policy =  Pundit.policy(current_admin, clazz)      
#             policy.public_methods(false).sort.each do |m|      
#                 result = policy.send m                    
#                 permissions["#{clazz}.#{m}"] = result     
#             end
#         end 
    
#         render json: permissions
#     end
# end