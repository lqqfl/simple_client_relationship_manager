class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_relationship, only: [:destroy]
  before_action :get_counts, only: [:index, :destroy]
  def index
  end

  def destroy
    @relationship.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to relationships_url, notice: 'Relationship was successfully destroyed.' }
    end
  end

  private
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    def get_counts
      @relationships = Relationship.paginate(:page => params[:page], :per_page => 15)
      @relationship_counts = Relationship.count  
    end
end
