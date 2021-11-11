class System::BranchesController < System::SystemApplicationController
    before_action :set_branch, only: [:show, :edit, :update, :destroy]

    
    
    def index
        @pagy, @branches = pagy(policy_scope(Branch.all.order(id: :asc)))
        authorize @branches
        
        if params[:search]
            @search_term = params[:search]
            @branches = @branches.search_by(@search_term)
        end

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
                template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb",
                header: { right: "#{@pagy.page} of #{@pagy.last}" }
            end
          end
    end

    def show
    end

    def new
        @branch = Branch.new
        authorize @branch
    end

    def create
        @branch = Branch.new(branch_params)
        authorize @branch

        if @branch.save
            redirect_to system_branches_path
            flash[:notice] = "Branch #{@branch.name} was successfully created."
        else
            flash.now[:alert] =  @branch.errors.full_messages
            render :new
            
        end
    end

    def edit
    end

    def update
        if @branch.update(branch_params)
            redirect_to system_branches_path
            flash[:notice] = "Branch was successfully updated."
        else
            flash.now[:alert] = @branch.errors.full_messages
            render :edit
        end
    end

    def destroy
        if @branch.destroy
            redirect_to system_branches_path
            flash[:notice] = "Branch was successfully destroyed."
        end
    end

    private

    def set_branch
        @branch = Branch.find(params[:id])
        authorize @branch
    end

    def branch_params
        params.require(:branch).permit(:name, :longitude, :latitude, :link, :city_id, :address)
    end
end
