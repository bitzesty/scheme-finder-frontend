class PagesController < ApplicationController
  skip_before_action :maintenance_page, only: :maintenance

  def about
  end

  def start
  end

  def intro
  end

  def maintenance
  end
end
