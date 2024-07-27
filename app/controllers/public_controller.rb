class PublicController < ApplicationController
  before_action :authenticate_user!, unless: :admin_controller?
  
  private
 
  def admin_controller?
    self.class.module_parent_name == "Admin"
  end
  
  
end