class OpportunitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]
  before_action :get_counts, except: [:new]

  # GET /opportunities
  # GET /opportunities.json
  def index
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
  end

  # GET /opportunities/1/edit
  def edit
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    @opportunity = Opportunity.new(opportunity_params)

    respond_to do |format|
      if @opportunity.save

        relationship_operator(relation_params)
        format.js
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity }
      else
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        relationship_operator(relation_params)
        format.js
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @opportunity }
      else
        format.html { render :edit }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    empty_relationship(@opportunity.id)
    @opportunity.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to opportunities_url, notice: 'Opportunity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      params.require(:opportunity).permit(:name, :note)
    end

    def relation_params
      params.require(:opportunity).permit(:users, :companies, :contacts, :activities)
    end

    def empty_relationship(id)
      rels = Relationship.where(opportunity_id: id)
      rels.map{ |item| item.activity_id = 0; item.save! }
    end

    def relationship_operator(parameters)
      user_id = parameters[:users] == "" ? 0 : parameters[:users]
      company_id = parameters[:companies] == "" ? 0 : parameters[:companies]
      contact_id = parameters[:contacts] == "" ? 0 : parameters[:contacts]
      activity_id = parameters[:activities] == "" ? 0 : parameters[:activities]
      return if user_id == 0 && company_id == 0 && contact_id == 0

      relationship = search_relationship({user_id: user_id, company_id: company_id, contact_id: contact_id, activity_id: activity_id, opportunity_id: 0})
      relationship2 = search_relationship({user_id: user_id, company_id: company_id, contact_id: contact_id, activity_id: 0, opportunity_id: 0})
      if relationship
        relationship.update_attributes(opportunity_id: @opportunity.id)
      elsif relationship2
        relationship2.update_attributes(opportunity_id: @opportunity.id, activity_id: activity_id)
      else
        Relationship.create!(user_id: user_id, company_id: company_id, contact_id: contact_id, activity_id: activity_id, opportunity_id: @opportunity.id)
      end
    end

    def get_counts
      @q = Opportunity.search(params[:q])
      @opportunities = @q.result.paginate(page: params[:page], per_page: 5)
      @opportunity_counts = Opportunity.count      
    end
end
