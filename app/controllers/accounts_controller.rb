class AccountsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :get_counts, except: [:new]
  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @account = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @account = User.new(user_params)
    respond_to do |format|
      if @account.save
        format.js {}
        format.html { redirect_to account_path(@account), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @account.remove_avatar! if @account.avatar? == 1
    respond_to do |format|
      if @account.update user_params
        format.js {}
        format.html { redirect_to account_path(@account), notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to accounts_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @account = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:account).permit(:name, :note, :email,:avatar,:avatar_cache,:remote_avatar_url,:remove_avatar,:password)
    end

    def search_parms
      params.require(:q).permit(:name,:note,:email)
    end

    def get_counts
      @q = User.search(params[:q])
      @accounts = @q.result.paginate(:page => params[:page], :per_page => 5)
      @account_counts = User.count
    end
end
