class System::StaticPagesController < System::SystemApplicationController
 
  def home
    policy_scope(:static_pages)
    authorize :static_pages
  end
end
