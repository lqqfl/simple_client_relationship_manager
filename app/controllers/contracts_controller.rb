class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
    @contract_counts = Contract.count
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        relationship_operator(relation_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        relationship_operator(relation_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    empty_relationship(@contract.id)
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:name, :exp_amount, :real_amount,:note, :start_time, :end_time)  
    end

    def relation_params
      params.require(:contract).permit(:users, :opportunities, :companies, :contacts)
    end

    def empty_relationship(id)
      rels = Relationship.where(opportunity_id: id)
      rels.map{ |item| item.activity_id = 0; item.save! }
    end

    def relationship_operator(parameters)
      user_id = parameters[:users] == "" ? 0 : parameters[:users]
      company_id = parameters[:companies] == "" ? 0 : parameters[:companies]
      contact_id = parameters[:contacts] == "" ? 0 : parameters[:contacts]
      opportunity_id = parameters[:opportunities] == "" ? 0 : parameters[:opportunities]
      return if user_id == 0 && opportunity_id == 0 && contact_id == 0 && company_id == 0

      relationship = search_relationship({user_id: user_id, company_id: company_id, contact_id: contact_id, opportunity_id: opportunity_id, contract_id: 0})
      relationship2 = search_relationship({user_id: user_id, company_id: company_id, contact_id: contact_id, opportunity_id: 0, contract_id: 0})

      if relationship
        relationship.update_attributes(contract_id: @contract.id)
      elsif relationship2
        relationship2.update_attributes(contact_id: @contract.id, opportunity_id: opportunity_id)
      else
        Relationship.create!(user_id: user_id, company_id: company_id, contact_id: contact_id, opportunity_id: opportunity_id,contract_id: @contract.id)
      end
    end    
end
