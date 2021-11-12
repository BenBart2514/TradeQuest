class QuestingController < ApplicationController
    def index
        @page_name = "Questing"
        @top_link = "Go to Marketplace"
        @link_path = root_path
    end
end
