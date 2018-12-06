class CrimeInvestigationsController < ApplicationController
  before_action :check_login
  authorize_resource

  def new
    @crime_investigation = CrimeInvestigation.new
    unless params[:crime_id].nil?
      @crime   = Crime.find(params[:crime_id])
    end

  end
  
  def create
    @crime_investigation = CrimeInvestigation.new(crime_investigation_params)
    if @crime_investigation.save
      flash[:notice] = "Successfully added crime investigation."
      redirect_to investigation_path(@crime_investigation.investigation)

    else
      @crime = Crime.find(params[:crime_investigation][:crime_id])
      render action: 'new', locals: { crime: @crime }
    end
  end

  private
  def crime_investigation_params
    params.require(:crime_investigation).permit(:investigation_id, :crime_id)
  end
end