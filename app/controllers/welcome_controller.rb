class WelcomeController < ApplicationController
  def index
    @new = Bit.order('created_at DESC').first()

    hot_bits = Bit.where("bits.created_at > ?", 1.week.ago)
    hot_bits = hot_bits.sort_by{ |bit| -1 * bit.hotness }
    @hot = hot_bits.first
  end
end
