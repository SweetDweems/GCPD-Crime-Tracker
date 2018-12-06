class InvestigationNotesController < ApplicationController
  before_action :check_login
  authorize_resource

  def new
    @investigation_note = InvestigationNote.new
    unless params[:officer_id].nil?
      @officer = Officer.find(params[:officer_id])
    end
  end

  def create
    @investigation_note = InvesetigationNote.new(investigation_note_params)
    if @investigation_note.save
      flash[:notice] = "Successfully added note."
      redirect_to investigation_path(@investigation_note.investigation)

    else
      @officer    = Officer.find(params[:investigation_note][:officer_id])
      render action: 'new', locals: { officer: @officer }
    end
  end

  private
  def investigation_note_params
    params.require(:investigation_note).permit(:investigation_id, :officer_id, :date)
  end
end