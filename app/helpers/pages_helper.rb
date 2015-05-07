module PagesHelper
  def print_query
    # {"q"=>"busqueee", "state"=>"2", "jury"=>"40", "date"=>"05/07/2015", "controller"=>"pages", "action"=>"search"}
    html = '<ul>'
    html += "<li>Busqueda: #{params[:q]}</li>" unless params[:q].blank?
    html += "<li>Estado: #{State.find(params[:state]).name}</li>" unless params[:state].blank?
    html += "<li>Jurado: #{Tribunal.find(params[:jury]).name}</li>" unless params[:jury].blank?
    html += "<li>Fecha: #{params[:date]}</li>" unless params[:date].blank?
    html += '</ul>'
    raw html
  end
end
