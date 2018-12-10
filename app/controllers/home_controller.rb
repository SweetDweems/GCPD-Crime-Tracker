class HomeController < ApplicationController
  def index
    if logged_in?
      @officer = current_user.officer
      if current_user.role?(:officer)
        officer_dash()
      elsif current_user.role?(:chief)
        chief_dash()
      elsif current_user.role?(:commish)
        commish_dash()
      end
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
  end

  private
  def officer_dash
    @current_assignments = @officer.assignments.current.chronological
    officer_notes = []
    for note in @officer.investigation_notes do
      if note.investigation.date_closed.nil?
        officer_notes << note
      end
    end
    @officer_notes = officer_notes.sort_by{|n| n.date}.last(3)
    recent_notes = []
    for assignment in @current_assignments do
      recent_notes += assignment.investigation.investigation_notes
    end
    @recent_notes = recent_notes.sort_by{|n| n.date}.last(3) - @officer_notes
  end

  def chief_dash
    @unit = @officer.unit
    @officers = @unit.officers.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @investigations = Investigation.is_open.chronological.select{|i| i.assignments.count == 0}.last(5)
  end

  def commish_dash
    @units = Unit.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @investigations = Investigation.is_open.chronological.last(5)
  end

end
