class FilialsController < ApplicationController
    def index
        @filials = Filial.all   #.sort_by(&:anni)  #doesn't work when anni nil
    end

    def show
        @filial = Filial.find(params[:id])
    end

    def new
        @filial = Filial.new
    end
    
    def create
        @filial = Filial.create(filial_params)
        if request.referer.include?("/filials")
            redirect_to filial_path(@filial)
        elsif request.referer.include?("/people")
            redirect_back fallback_location: person_path(@filial.parent)
        else
            redirect_to root_path
        end
    end

    def edit
        @filial = Filial.find(params[:id])
    end

    def update
        @filial = Filial.find(params[:id])
        @filial.update(filial_params)
        redirect_to filial_path(@filial)
    end

    def destroy
        @filial = Filial.find(params[:id])
        @filial.destroy
        redirect_to filials_path
    end

    private
    def filial_params
        params.require(:filial).permit(:name, :anni, :parent_name, :child_name, :parent_id, :child_id)
    end
end
