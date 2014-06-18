class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :get_counts, only: [:index, :create, :update,:destroy]
  # GET /contacts
  # GET /contacts.json
  def index
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    respond_to do |f|
      f.js{}
    end
  end

  # GET /contacts/1/edit
  def edit

  end

  # POST /contacts
  # POST /contacts.json
  def create
    parameters = contact_params
    @contact = Contact.new(name: parameters[:name], note: parameters[:note])
    respond_to do |format|
      if @contact.save
        relationship_operator(parameters)
        format.js {}
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    parameters = contact_params

    respond_to do |format|
      if @contact.update(name: parameters[:name], note: parameters[:note])
        relationship_operator(contact_params)
        format.js
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    empty_relationship(@contact.id)
    @contact.destroy

    respond_to do |format|
      format.js {}
      # format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :note, :users, :companies)
    end

    def empty_relationship(id)
      rels = Relationship.where(contact_id: id)
      rels.map{ |item| item.contact_id = 0; item.save! }
    end

    def relationship_operator(parameters)
      user_id = parameters[:users] == "" ? 0 : parameters[:users]
      company_id = parameters[:companies] == "" ? 0 : parameters[:companies]
      return if user_id == 0 && company_id == 0

      relationship = search_relationship({user_id: user_id, company_id: company_id, contact_id: 0})
      relationship2 = search_relationship({user_id: 0, company_id: company_id, contact_id: @contact.id})
      relationship3 = search_relationship({user_id: user_id, company_id: 0, contact_id: @contact.id})
      relationship4 = search_relationship({company_id: 0, contact_id: @contact.id})

      if relationship3
        relationship3.update_attributes(company_id: company_id)
      elsif relationship2
        relationship2.update_attributes(user_id: user_id)
      elsif relationship
        relationship.update_attributes(contact_id: @contact.id)
      elsif relationship4
        relationship4.update_attributes(company_id: company_id)
      else
        Relationship.create!(user_id: user_id, company_id: company_id, contact_id: @contact.id)
      end    
    end

    def get_counts
      @contact_counts = Contact.count  
      @q = Contact.search(params[:q])
      @contacts = @q.result.paginate(page: params[:page], per_page: 5)      
    end
end
