class StaticPagesController < ApplicationController
  def home
  	@home_page = true
  end

  def help
  end

  def about
  end

  def faq
  end
end
