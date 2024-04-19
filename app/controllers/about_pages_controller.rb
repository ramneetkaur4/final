class AboutPagesController < ApplicationController
  def show
    @about_page = AboutPage.last
  end
end
