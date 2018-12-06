class SuspectsController < ApplicationController
  before_action :check_login
  authorize_resource

  def new
    @suspect = Suspect.new
    unless params[:criminal_id].nil?
      @criminal = Criminal.find(params[:criminal_id])
      @criminal_investigations = @criminal.suspects.current.map{|s| s.investigation}
    end
  end

  def create
    @suspect = Suspect.new(suspect_params)
    @suspect.added_on = Date.current
    if @suspect.save
      flash[:notice] = "Successfully added #{suspect.criminal.name} as a suspect."
      redirect_to investigation_path(@suspect.investigation)

    else
      @criminal    = Criminal.find(params[:assignment][:criminal_id])
      render action: 'new', locals: { criminal: @criminal }
    end
  end

  def terminate
    @suspect = Suspect.find(params[:id])
    @suspect.dropped_on = Date.current
    @suspect.save
    redirect_to investigation_path(@suspect.invesetigation)
  end

  private
  def suspect_params
    params.require(:suspect).permit(:investigation_id, :officer_id, :added_on, :dropped_on)
  end
end