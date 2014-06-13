class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    @contact_counts = Contact.count
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
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
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
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

    def relationship_operator(parameters)
      user_id = parameters[:users] || 0
      company_id = parameters[:companies] || 0
      relationship = search_relationship({user_id: user_id, company_id: company_id, contact_id: 0})
      if relationship
        relationship.update_attributes(contact_id: @contact.id)
      else
        Relationship.create!(user_id: user_id, company_id: company_id, contact_id: @contact.id)
      end    
    end

end
