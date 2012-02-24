class WelcomeController < ApplicationController
  caches_page :index, :about
  def index
    @top = Bit.plusminus_tally.first()
    @new = Bit.order('created_at DESC').first()
  end
end
