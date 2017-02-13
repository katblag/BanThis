class PeopleController < ApplicationController
  http_basic_authenticate_with name: "banthisthecampaign", password: "sameenmaria", only: [:edit, :update, :publish, :destroy]
  
  def index
    @people = Person.published
  end
  
  def show
    @person = Person.find(params[:id])
  end
  
  def new
    @person = Person.new
  end
  
  def edit
    @person = Person.find(params[:id])
  end
    
  def create
    params[:person][:published] = false
    @person = Person.new(person_params)
 
    if @person.save
      flash.now[:notice] = "Thank you for your submission!"
      redirect_to new_person_path
    else
      flash.now[:error] = "Sorry, there was a problem submitting your info. Please email your submission to banthisthecampaign@gmail.com"
      render 'new'
    end
  end
  
  def update
    @person = Person.find(params[:id])
 
    if @person.update(person_params)
      redirect_to @person
    else
      render 'edit'
    end
  end
  
  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to root_path
  end
  
  def publish
    @person = Person.find(params[:person_id])
    @person.published = true
    @person.save
    redirect_to @person
  end
  
  private
  def person_params
    params.require(:person).permit(:photo, :name, :trajectory, :age, :occupation, :migration_reason, :value_prop, :story, :location, :weight, :group_id, :published)
  end
end