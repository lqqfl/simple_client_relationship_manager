class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :get_counts, only: [:index, :update, :destroy, :create]
  # GET /companies
  # GET /companies.json
  def index
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    parameters = company_params
    @company = Company.new(name: parameters[:name], note: parameters[:note])

    respond_to do |format|
      if @company.save
        relationship_operator(parameters)
        format.js
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    parameters = company_params
    respond_to do |format|
      if @company.update(name: parameters[:name], note: parameters[:note])
        if relationship_operator(parameters)
          format.js
          format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        else
          format.html { redirect_to @company, notice: 'The company has associated the user you selected.' }
        end
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    empty_relationship(@company.id)
    @company.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :note, :users)
    end

    def get_counts
      @q = Company.search(params[:q])
      @companies = @q.result.paginate(:page => params[:page], :per_page => 5)
      @company_counts = Company.count         
    end

    def empty_relationship(id)
      rels = Relationship.where(company_id: id)
      rels.map{ |item| item.company_id = 0; item.save! }
    end

    def relationship_operator(parameters)
      user_id = parameters[:users] == "" ? 0 : parameters[:users]
      relationship = search_relationship({user_id: user_id, company_id: 0, contact_id: 0})
      relationship2 = search_relationship({user_id: user_id, company_id: @company_id})
      if relationship2
        false
      elsif relationship
        relationship.update_attributes(company_id: @company.id)
        true
      else
        Relationship.create!(user_id: user_id, company_id: @company.id, contact_id: 0)
        true
      end
    end    
end
