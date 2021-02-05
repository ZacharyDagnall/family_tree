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
        @marriage = Marriage.create(marriage_params)
        if request.referer.include?("/marriages")
            redirect_to marriage_path(@marriage)
        elsif request.referer.include?("/people")
            redirect_back fallback_location: person_path(@marriage.husband)
        else
            redirect_to root_path
        end
    end

    def edit
        @marriage = Marriage.find(params[:id])
    end

    def update
        @marriage = Marriage.find(params[:id])
        @marriage.update(marriage_params)
        redirect_to marriage_path(@marriage)
    end

    def destroy
        @marriage = Marriage.find(params[:id])
        @marriage.destroy
        redirect_to marriages_path
    end

    private
    def marriage_params
        params.require(:marriage).permit(:name, :anni, :husband_name, :wife_name, :husband_id, :wife_id)
    end

end
