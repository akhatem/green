class System::BranchesController < ApplicationController
    before_action :set_branch, only: [:show, :edit, :update, :destroy]
    
    def index
        @branches = Branch.paginate(page: params[:page], per_page: 10).order(id: :asc)
    end

    def show
        @branch = Branch.find(params[:id])
    end

    def new
        # byebug
        @branch = Branch.new
        puts "Branch: #{@branch}"
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
        respond_to do |format|
            if @branch.write_attribute(:name, branch_params[:name])
              format.html { redirect_to system_branches_path, notice: "Branch #{@branch.name} was successfully edited." }
              format.json { render :show, status: :ok, location: @branch }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @branch.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            byebug
          if @branch.update(name: branch_params[:name])
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
    end

    def branch_params
        params.fetch(:branch, {})
        # params.require(:branch).permit(:name)
    end
end
