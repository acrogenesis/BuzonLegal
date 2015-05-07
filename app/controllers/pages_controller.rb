class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:jury]

  def index
    render layout: 'landing'
  end

  def search
    date = params[:date]
    @cases = Case
    if date.present? && params[:jury].present?
      date =  Date.strptime(date, '%m/%d/%Y')
      @cases = @cases.where(tribunal_id: params[:jury], date: date)
    elsif date.present?
      @cases = @cases.where(date: date)
    elsif params[:jury].present?
      @cases = @cases.where(tribunal_id: params[:jury])
    end
    @cases = @cases.where('casenumber ILIKE :q OR description ILIKE :q', q: "%#{params[:q]}%")
  end

  def case
    @cases = Case.where(casenumber: params[:q])
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

  def jury
    respond_to do |format|
      format.json { render json: { options: Tribunal.where(state_id: params[:state_id]).pluck(:name, :id) } }
    end
  end
end
