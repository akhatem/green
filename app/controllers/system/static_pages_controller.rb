class System::StaticPagesController < System::SystemApplicationController
 
  def index
    policy_scope(:static_pages)
    authorize :static_pages
  end
end
