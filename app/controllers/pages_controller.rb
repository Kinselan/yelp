class PagesController < ApplicationController

    def front
      @businesses = Business.all
    end

end
