class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:destroy]
  def index
    @relationships = Relationship.all
    @relationship_counts = Relationship.count
  end

  def destroy
    @relationship.destroy

    respond_to do |format|
      format.html { redirect_to relationships_url, notice: 'Relationship was successfully destroyed.' }
    end
  end

  private
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end
end
