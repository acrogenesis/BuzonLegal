class PagesController < ApplicationController
  def index
    render layout: "landing"
  end

  def search
  end

  def advanced
    render layout: 'landing'
  end

  def faq
  end

  def privacy
  end

  def status
    @states = State.all
    @incidents_by_date = Incident.where(created_at: Date.current..(Date.current - 3.months)).order(created_at: :desc).group_by { |incid| incid.created_at.day }.values
  end
end
