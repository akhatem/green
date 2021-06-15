class System::SystemApplicationController < ApplicationController
    before_action :authenticate_system_user!
end