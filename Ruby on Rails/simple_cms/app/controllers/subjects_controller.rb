class SubjectsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  #index action display list of records
  def index
    #sorted is scope in model
    @subjects = Subject.sorted
  end

  #show action display a detailed view of single record
  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new(:name => "Default")
    @subject_count = Subject.count + 1
  end

  def create
    #Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    #Save the object
    if @subject.save
      #if save succeeds, redirect to index action
      flash[:notice] = "Successfully created..." #to send messeages to next request
      redirect_to(:action => 'index')
    else
      #if save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    #Find an existing object using form parameters
    @subject = Subject.find(params[:id])
    #Update the object
    if @subject.update_attributes(subject_params)
      #if udpate succeeds, redirect to index action
      flash[:notice] = "Successfully updated..." #to send messeages to next request
      redirect_to(:action => 'show' , :id => @subject.id)
    else
      #if update fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Successfully '#{subject.name}'destroyed..."  #to send messeages to next request
    redirect_to(:action => 'index')
  end

  private

    def subject_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:subject).permit(:name , :position , :visible)
    end

end
