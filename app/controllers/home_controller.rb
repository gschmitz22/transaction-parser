class HomeController < ApplicationController
  def index
    @account = Account.find_by('1')
  end
end
