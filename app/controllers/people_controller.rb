class PeopleController < ApplicationController
    def index
        @people = Person.all.sort_by(&:age).reverse
    end

    def show
        @person = Person.find(params[:id])
        @marriage = Marriage.new
        @filial = Filial.new
    end

    def new
        @person = Person.new
    end
    
    def create
        @person = Person.create(people_params)
        redirect_to person_path(@person)
    end

    def edit
        @person = Person.find(params[:id])
    end

    def update
        @person = Person.find(params[:id])
        @person.update(people_params)
        redirect_to person_path(@person)
    end

    def destroy
        @person = Person.find(params[:id])
        @person.destroy
        redirect_to people_path
    end

    private
    def people_params
        params.require(:person).permit(:name, :dob, :age)
    end
end
