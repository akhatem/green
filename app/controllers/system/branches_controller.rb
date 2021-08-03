class System::BranchesController < System::SystemApplicationController
    before_action :set_branch, only: [:show, :edit, :update, :destroy]

    
    
    def index
        @pagy, @branches = pagy(Branch.all.order(id: :asc))
        if params[:search]
            @search_term = params[:search]
            @branches = @branches.search_by(@search_term)
        end

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
                template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb"
            end
        end
    end

    def show
        
    end

    def new
        @branch = Branch.new
    end

    def create
        @branch = Branch.new(branch_params)

        respond_to do |format|
            if @branch.save
                format.html { redirect_to system_branches_path, notice: "Branch #{@branch.name} was successfully created." }
                format.json { render :show, status: :created, location: @branch }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @branch.errors, status: :unprocessable_entity }
                
            end
        end
    end

    def edit
    end

    def update
        respond_to do |format|
          if @branch.update(branch_params)
            format.html { redirect_to system_branches_path, notice: "Branch was successfully updated." }
            format.json { render :show, status: :ok, location: @branch }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @branch.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        def destroy
            @branch.destroy
            respond_to do |format|
                format.html { redirect_to system_branches_path, notice: "Branch was successfully destroyed." }
                format.json { head :no_content }
              end
        end
    end

    private

    def set_branch
        @branch = Branch.find(params[:id])
        authorize @branch
    end

    def branch_params
        params.require(:branch).permit(:name, :long, :lat, :link, :city_id, :address)
    end
end
