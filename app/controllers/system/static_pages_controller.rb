class System::StaticPagesController < System::SystemApplicationController
 
  def index
    authorize :static_pages_controller
  end
end
