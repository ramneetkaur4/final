class ContactPagesController < ApplicationController
  def show
    @contact_page = ContactPage.last
  end
end
