class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :get_counts, only: [:index, :show, :update, :create,:destroy]
  # GET /activities
  # GET /activities.json
  def index
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    
    respond_to do |f|
      if @activity.save
        relationship_operator(relation_params)
        f.js {}
        f.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        f.json { render :show, status: :created, location: @activity }
      else
        f.html { render :new }
        f.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        relationship_operator(relation_params)
        format.js
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    empty_relationship(@activity.id)
    @activity.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :time, :note)
    end

    def get_counts
      @activities = Activity.all.paginate(page: params[:page], per_page: 5)
      @activity_counts = Activity.count  
    end

    def relation_params
      params.require(:activity).permit(:users, :companies, :contacts)
    end

    def empty_relationship(id)
      rels = Relationship.where(activity_id: id)
      rels.map{ |item| item.activity_id = 0; item.save! }
    end

    def relationship_operator(parameters)
      user_id = parameters[:users] == "" ? 0 : parameters[:users]
      company_id = parameters[:companies] == "" ? 0 : parameters[:companies]
      contact_id = parameters[:contacts] == "" ? 0 : parameters[:contacts]
      return if user_id == 0 && company_id == 0 && contact_id == 0

      relationship = search_relationship({user_id: user_id, company_id: company_id, contact_id: contact_id, activity_id: 0})

      if relationship
        relationship.update_attributes(activity_id: @activity.id)
      else
        Relationship.create!(user_id: user_id, company_id: company_id, contact_id: contact_id, activity_id: @activity.id)
      end
    end      
end
