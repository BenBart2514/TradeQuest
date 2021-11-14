class QuestsController < ApplicationController
  def index
    @page_name = 'Questing'
    @top_link = 'Marketplace'
    @link_path = root_path
  end
end
