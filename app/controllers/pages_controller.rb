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
  end
end
