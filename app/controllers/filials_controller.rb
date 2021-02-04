class FilialsController < ApplicationController
    def index
        @filials = Filial.all.sort_by(&:anni)
    end

    def show
        @filial = Filial.find(params[:id])
    end

    def new
        @filial = Filial.new
    end
    
    def create
        @filial = Filial.create(filials_params)
        redirect_to filial_path(@filial)
    end

    def edit
        @filial = Filial.find(params[:id])
    end

    def update
        @filial = Filial.find(params[:id])
        @filial.update(filials_params)
        redirect_to filial_path(@filial)
    end

    def destroy
        @filial = Filial.find(params[:id])
        @filial.destroy
        redirect_to filials_path
    end

    private
    def filials_params
        params.require(:filial).permit(:name, :anni, :parent_name, :child_name, :parent_id, :child_id)
    end
end
