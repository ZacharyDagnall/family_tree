class MarriagesController < ApplicationController
    
    def index
        @marriages = Marriage.all.sort_by(&:anni)
    end

    def show
        @marriage = Marriage.find(params[:id])
    end

    def new
        @marriage = Marriage.new
    end
    
    def create
        @marriage = Marriage.create(marriages_params)
        redirect_to marriage_path(@marriage)
    end

    def edit
        @marriage = Marriage.find(params[:id])
    end

    def update
        @marriage = Marriage.find(params[:id])
        @marriage.update(marriages_params)
        redirect_to marriage_path(@marriage)
    end

    def destroy
        @marriage = Marriage.find(params[:id])
        @marriage.destroy
        redirect_to marriages_path
    end

    private
    def marriages_params
        params.require(:marriage).permit(:name, :anni, :husband_name, :wife_name, :husband_id, :wife_id)
    end

end
